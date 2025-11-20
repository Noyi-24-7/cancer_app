import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";

import { executeWorkflow } from "@/lib/educationalContentProcessor";

export const runtime = "nodejs";
export const maxDuration = 60;

const payloadSchema = z.object({
  articlesJson: z.union([z.string(), z.record(z.any()), z.array(z.any())]).optional(),
  articles: z.union([z.record(z.any()), z.array(z.any())]).optional(),
  targetLanguage: z.string().min(2),
  action: z.enum(["translate_only", "audio_only", "translate_and_audio"]).optional(),
  articleId: z.string().optional(),
});

const serializeArticles = (value: unknown) => {
  if (typeof value === "string") {
    return value;
  }
  if (value === undefined) {
    return undefined;
  }
  return JSON.stringify(value);
};

export async function GET() {
  return NextResponse.json({ status: "ok", timestamp: new Date().toISOString() });
}

export async function POST(request: NextRequest) {
  try {
    const rawPayload = await request.json().catch(() => ({}));
    const parsed = payloadSchema.safeParse(rawPayload);

    if (!parsed.success) {
      return NextResponse.json(
        {
          success: false,
          error: "Invalid payload",
          details: parsed.error.flatten().fieldErrors,
        },
        { status: 400 }
      );
    }

    const { articlesJson, articles, targetLanguage, action, articleId } = parsed.data;
    const resolvedArticlesJson = serializeArticles(articlesJson ?? articles);

    if (!resolvedArticlesJson) {
      return NextResponse.json(
        {
          success: false,
          error: "Either articlesJson or articles must be provided",
        },
        { status: 400 }
      );
    }

    const workflowResult = await executeWorkflow({
      articlesJson: resolvedArticlesJson,
      targetLanguage,
      action,
      articleId,
    });

    return NextResponse.json({
      success: true,
      result: workflowResult,
    });
  } catch (error: unknown) {
    return NextResponse.json(
      {
        success: false,
        error: error instanceof Error ? error.message : "Unexpected error",
      },
      { status: 500 }
    );
  }
}

