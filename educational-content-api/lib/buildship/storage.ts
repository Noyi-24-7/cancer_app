type BucketFileStub = {
  makePublic: () => Promise<never>;
  publicUrl: () => never;
};

export const bucket = {
  file: (_path?: string): BucketFileStub => ({
    async makePublic() {
      throw new Error("Google Cloud Storage is not configured for this deployment.");
    },
    publicUrl() {
      throw new Error("Google Cloud Storage is not configured for this deployment.");
    },
  }),
};
