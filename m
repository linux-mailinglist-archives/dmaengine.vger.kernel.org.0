Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF66C3684
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 17:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjCUQEA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCUQD7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 12:03:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C7E3A9
        for <dmaengine@vger.kernel.org>; Tue, 21 Mar 2023 09:03:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i9so14240344wrp.3
        for <dmaengine@vger.kernel.org>; Tue, 21 Mar 2023 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679414614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBFhkieZr9DcuH6OJpwJsbd/MbRISB1FzuiRurd/kIk=;
        b=IL3ZCoCYj4B/O3srxixE3h6c05Wfxg3mSFLufKAApxNlqelq27jWZxS5gMci89s4r5
         lXfCScam1X7em3wQJJCJgliEaPBCUD/z5dUyZiElUIgVcHA+gk5fj7fSwJMCGEMFUZqf
         3aANDmHHwHU6hVOs7oq5R5k/V1zK1YmZBBc4oVGwQbkjjoAaQn4PRg/TztBsa+ZqRsgY
         F9T6DYPHZaHwAz42Cf0loScdz9KTt/diC5sVybKwsfcHJ2qaurT49HWFvS2cphGogA9t
         MoeQx0HXbzqkNgTFcM+oTL5wKw+N12sHaI0I8Qa6PXr48/URvzsk8vBh6Te+R+D8rTWL
         WK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679414614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBFhkieZr9DcuH6OJpwJsbd/MbRISB1FzuiRurd/kIk=;
        b=Hh6IVoQ1Acgnr4uFycM1+O++vuyQc/3qyvMX+An2gMCUJy0s3hbj15inl9TUvNgxWx
         /oPJC2HxsdoJgnhITmAcvsBRDsfGDmb5IKs6i6DvRZjsUgqyslBSdwkKKfe9Senm/Ggg
         I8+4H3mA1p74sgnen+GvIsrH9zegKglSg3O2AnhhE2SKnL1Z6ZT1I4U6I9gwHNO1v6Mn
         ZQwDVXcQ75pkZ/TWl+mUeSsu2FJAHtFhbr1kffQkzr5lZsnC5GQ0ZAyz5ZoVo5u/6k9y
         n4LeaXDgHbd/obILdahOliUmiWMaA9mmkD9xvYf88V1PbjQ8E9R70hnF1fkHDVTOiUsI
         Z3OA==
X-Gm-Message-State: AO0yUKWlm8sKq5KmAJ6TNQvHQYnbN4uHlJ6rsmxu8kC7hNZ+uH0NAS5m
        Mmq5hUweUNpRMmI2E01zyMee143Rm1Q9+1I1mZK1uw==
X-Google-Smtp-Source: AK7set95EfyofHHtmSWBMscXwg5vI+T4k/84bdeGYxo+YyXaCgq00QA7D8cd3DcaKmvFISBI6jcJ+Q==
X-Received: by 2002:a5d:5685:0:b0:2ce:a835:83d4 with SMTP id f5-20020a5d5685000000b002cea83583d4mr2804100wrv.27.1679414613718;
        Tue, 21 Mar 2023 09:03:33 -0700 (PDT)
Received: from localhost.localdomain ([90.243.20.231])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b002c55521903bsm11611094wrt.51.2023.03.21.09.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:03:33 -0700 (PDT)
From:   Niyas Sait <niyas.sait@linaro.org>
To:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-acpi@vger.kernel.org, Sudeep.Holla@arm.com,
        Souvik.Chakravarty@arm.com, Sunny.Wang@arm.com,
        lorenzo.pieralisi@linaro.org, bob.zhang@cixtech.com,
        fugang.duan@cixtech.com
Cc:     Niyas Sait <niyas.sait@linaro.org>
Subject: [RFC v1 1/1] Refactor ACPI DMA to support platforms without shared info descriptor in CSRT
Date:   Tue, 21 Mar 2023 16:02:41 +0000
Message-Id: <20230321160241.1339538-1-niyas.sait@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch refactors the ACPI DMA layer to support platforms without
shared info descriptor in CSRT.

Shared info descriptor is optional and vendor specific (not
standardized) and not used by Arm platforms.
---

The main changes in this patch are as follows:

- Renamed acpi_dma_controller_register to acpi_dma_controller_register_with_csrt_shared_desc to reflect its new functionality. 
- Refactored acpi_dma_controller_register to allow DMA controllers to be registered without CSRT walk. 
- Introduced acpi_dma_get_csrt_dma_descriptors_by_uid function to retrieve DMA descriptors from the CSRT table. 

An example usage is given below:

desc = acpi_dma_get_csrt_dma_descriptors_by_uid(adev, uid);

extract data from desc and populate the acpi dma descriptor

struct acpi_dma *adma = kzalloc(sizeof(*adma), GFP_KERNEL);

adma->dev = ...;
adma->acpi_dma_xlate = ...;
adma->data = ...;
adma->base_request_line = ...;
adma->end_request_line = ...;

ret = acpi_dma_controller_register(dev, adma);


 drivers/dma/acpi-dma.c   | 121 +++++++++++++++++++++++++++++++--------
 drivers/dma/dw/acpi.c    |   3 +-
 include/linux/acpi_dma.h |  44 +++++++++-----
 3 files changed, 128 insertions(+), 40 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 5906eae26e2a..4337e724d386 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -112,7 +112,7 @@ static int acpi_dma_parse_resource_group(const struct acpi_csrt_group *grp,
 }
 
 /**
- * acpi_dma_parse_csrt - parse CSRT to exctract additional DMA resources
+ * acpi_dma_parse_csrt_shared_info - parse CSRT shared info to extract additional DMA resources
  * @adev:	ACPI device to match with
  * @adma:	struct acpi_dma of the given DMA controller
  *
@@ -124,7 +124,7 @@ static int acpi_dma_parse_resource_group(const struct acpi_csrt_group *grp,
  * We are using this table to get the request line range of the specific DMA
  * controller to be used later.
  */
-static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
+static void acpi_dma_parse_csrt_shared_info(struct acpi_device *adev, struct acpi_dma *adma)
 {
 	struct acpi_csrt_group *grp, *end;
 	struct acpi_table_csrt *csrt;
@@ -157,12 +157,64 @@ static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
 }
 
 /**
- * acpi_dma_controller_register - Register a DMA controller to ACPI DMA helpers
- * @dev:		struct device of DMA controller
- * @acpi_dma_xlate:	translation function which converts a dma specifier
- *			into a dma_chan structure
- * @data:		pointer to controller specific data to be used by
- *			translation function
+ * acpi_dma_get_csrt_dma_descriptors_by_uid - Get DMA descriptor from CSRT table for given id
+ * @adev:		ACPI device node
+ * @uid:		Unique ID for look up
+ *
+ * Parse CSRT table and look for DMA descriptors matching the given ID
+ *
+ * Return:
+ * Pointer to DMA descriptor on success or NULL on error/no match.
+ */
+struct acpi_csrt_descriptor *
+acpi_dma_get_csrt_dma_descriptors_by_uid(struct acpi_device *adev, uint32_t uid)
+{
+	struct acpi_csrt_descriptor *desc, *desc_end, *desc_found = NULL;
+	struct acpi_csrt_group *grp, *grp_end;
+	struct acpi_table_csrt *csrt;
+	acpi_status status;
+
+	status = acpi_get_table(ACPI_SIG_CSRT, 0,
+				(struct acpi_table_header **)&csrt);
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND)
+			dev_warn(&adev->dev, "failed to get the CSRT table\n");
+		return NULL;
+	}
+
+	grp = (struct acpi_csrt_group *)(csrt + 1);
+	grp_end =
+		(struct acpi_csrt_group *)((void *)csrt + csrt->header.length);
+
+	while (grp < grp_end) {
+		desc = (struct acpi_csrt_descriptor *)((void *)(grp + 1) +
+						       grp->shared_info_length);
+		desc_end = (struct acpi_csrt_descriptor *)((void *)grp +
+							   grp->length);
+		while (desc < desc_end) {
+			if (desc->uid == uid) {
+				desc_found = desc;
+				goto found;
+			}
+			desc = (struct acpi_csrt_descriptor *)(((void *)desc) +
+							       desc->length);
+		}
+		grp = (struct acpi_csrt_group *)((void *)grp + grp->length);
+	}
+
+found:
+	acpi_put_table((struct acpi_table_header *)csrt);
+
+	return desc_found;
+}
+
+/**
+ * acpi_dma_controller_register_with_csrt_shared_desc - Register a DMA controller to ACPI DMA helpers
+ * @dev:                struct device of DMA controller
+ * @acpi_dma_xlate:     translation function which converts a dma specifier
+ *                      into a dma_chan structure
+ * @data:               pointer to controller specific data to be used by
+ *                      translation function
  *
  * Allocated memory should be freed with appropriate acpi_dma_controller_free()
  * call.
@@ -170,16 +222,14 @@ static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
  * Return:
  * 0 on success or appropriate errno value on error.
  */
-int acpi_dma_controller_register(struct device *dev,
-		struct dma_chan *(*acpi_dma_xlate)
-		(struct acpi_dma_spec *, struct acpi_dma *),
-		void *data)
+int acpi_dma_controller_register_with_csrt_shared_desc(
+	struct device *dev,
+	struct dma_chan *(*acpi_dma_xlate)(struct acpi_dma_spec *,
+					   struct acpi_dma *),
+	void *data)
 {
 	struct acpi_device *adev;
-	struct acpi_dma	*adma;
-
-	if (!dev || !acpi_dma_xlate)
-		return -EINVAL;
+	struct acpi_dma *adma;
 
 	/* Check if the device was enumerated by ACPI */
 	adev = ACPI_COMPANION(dev);
@@ -194,7 +244,34 @@ int acpi_dma_controller_register(struct device *dev,
 	adma->acpi_dma_xlate = acpi_dma_xlate;
 	adma->data = data;
 
-	acpi_dma_parse_csrt(adev, adma);
+	acpi_dma_parse_csrt_shared_info(adev, adma);
+
+	return acpi_dma_controller_register(dev, adma);
+}
+EXPORT_SYMBOL_GPL(acpi_dma_controller_register_with_csrt_shared_desc);
+
+/**
+ * acpi_dma_controller_register - Register a DMA controller to ACPI DMA helpers
+ * @dev:		struct device of DMA controller
+ * @adma:		ACPI DMA descriptor
+ *
+ * Allocated memory should be freed with appropriate acpi_dma_controller_free()
+ * call.
+ *
+ * Return:
+ * 0 on success or appropriate errno value on error.
+ */
+int acpi_dma_controller_register(struct device *dev, struct acpi_dma *adma)
+{
+	struct acpi_device *adev;
+
+	if (!dev || !adma || !adma->acpi_dma_xlate)
+		return -EINVAL;
+
+	/* Check if the device was enumerated by ACPI */
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -EINVAL;
 
 	/* Now queue acpi_dma controller structure in list */
 	mutex_lock(&acpi_dma_lock);
@@ -244,8 +321,7 @@ static void devm_acpi_dma_release(struct device *dev, void *res)
 /**
  * devm_acpi_dma_controller_register - resource managed acpi_dma_controller_register()
  * @dev:		device that is registering this DMA controller
- * @acpi_dma_xlate:	translation function
- * @data:		pointer to controller specific data
+ * @adma:		ACPI specific DMA descriptor
  *
  * Managed acpi_dma_controller_register(). DMA controller registered by this
  * function are automatically freed on driver detach. See
@@ -254,10 +330,7 @@ static void devm_acpi_dma_release(struct device *dev, void *res)
  * Return:
  * 0 on success or appropriate errno value on error.
  */
-int devm_acpi_dma_controller_register(struct device *dev,
-		struct dma_chan *(*acpi_dma_xlate)
-		(struct acpi_dma_spec *, struct acpi_dma *),
-		void *data)
+int devm_acpi_dma_controller_register(struct device *dev, struct acpi_dma *adma)
 {
 	void *res;
 	int ret;
@@ -266,7 +339,7 @@ int devm_acpi_dma_controller_register(struct device *dev,
 	if (!res)
 		return -ENOMEM;
 
-	ret = acpi_dma_controller_register(dev, acpi_dma_xlate, data);
+	ret = acpi_dma_controller_register(dev, adma);
 	if (ret) {
 		devres_free(res);
 		return ret;
diff --git a/drivers/dma/dw/acpi.c b/drivers/dma/dw/acpi.c
index c510c109d2c3..45d2707f4843 100644
--- a/drivers/dma/dw/acpi.c
+++ b/drivers/dma/dw/acpi.c
@@ -37,7 +37,8 @@ void dw_dma_acpi_controller_register(struct dw_dma *dw)
 	dma_cap_set(DMA_SLAVE, info->dma_cap);
 	info->filter_fn = dw_dma_acpi_filter;
 
-	ret = acpi_dma_controller_register(dev, acpi_dma_simple_xlate, info);
+	ret = acpi_dma_controller_register_with_csrt_shared_desc(
+		dev, acpi_dma_simple_xlate, info);
 	if (ret)
 		dev_err(dev, "could not register acpi_dma_controller\n");
 }
diff --git a/include/linux/acpi_dma.h b/include/linux/acpi_dma.h
index 72cedb916a9c..c2c50dcc9c07 100644
--- a/include/linux/acpi_dma.h
+++ b/include/linux/acpi_dma.h
@@ -56,15 +56,10 @@ struct acpi_dma_filter_info {
 
 #ifdef CONFIG_DMA_ACPI
 
-int acpi_dma_controller_register(struct device *dev,
-		struct dma_chan *(*acpi_dma_xlate)
-		(struct acpi_dma_spec *, struct acpi_dma *),
-		void *data);
+int acpi_dma_controller_register(struct device *dev, struct acpi_dma *adma);
 int acpi_dma_controller_free(struct device *dev);
 int devm_acpi_dma_controller_register(struct device *dev,
-		struct dma_chan *(*acpi_dma_xlate)
-		(struct acpi_dma_spec *, struct acpi_dma *),
-		void *data);
+				      struct acpi_dma *adma);
 void devm_acpi_dma_controller_free(struct device *dev);
 
 struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
@@ -74,23 +69,36 @@ struct dma_chan *acpi_dma_request_slave_chan_by_name(struct device *dev,
 
 struct dma_chan *acpi_dma_simple_xlate(struct acpi_dma_spec *dma_spec,
 				       struct acpi_dma *adma);
+struct acpi_csrt_descriptor *
+acpi_dma_get_csrt_dma_descriptors_by_uid(struct acpi_device *adev,
+					 uint32_t uid);
+int acpi_dma_controller_register_with_csrt_shared_desc(
+	struct device *dev,
+	struct dma_chan *(*acpi_dma_xlate)(struct acpi_dma_spec *,
+					   struct acpi_dma *),
+	void *data);
 #else
 
-static inline int acpi_dma_controller_register(struct device *dev,
-		struct dma_chan *(*acpi_dma_xlate)
-		(struct acpi_dma_spec *, struct acpi_dma *),
-		void *data)
+static inline int acpi_dma_controller_register(struct device *dev, struct acpi_dma *adma)
 {
 	return -ENODEV;
 }
+
+static inline int acpi_dma_controller_register_with_csrt_shared_desc(
+	struct device *dev,
+	struct dma_chan *(*acpi_dma_xlate)(struct acpi_dma_spec *,
+					   struct acpi_dma *),
+	void *data)
+{
+	return -ENODEV;
+}
+
 static inline int acpi_dma_controller_free(struct device *dev)
 {
 	return -ENODEV;
 }
 static inline int devm_acpi_dma_controller_register(struct device *dev,
-		struct dma_chan *(*acpi_dma_xlate)
-		(struct acpi_dma_spec *, struct acpi_dma *),
-		void *data)
+						    struct acpi_dma *adma)
 {
 	return -ENODEV;
 }
@@ -109,7 +117,13 @@ static inline struct dma_chan *acpi_dma_request_slave_chan_by_name(
 	return ERR_PTR(-ENODEV);
 }
 
-#define acpi_dma_simple_xlate	NULL
+static inline struct acpi_csrt_descriptor *
+acpi_dma_get_csrt_dma_descriptors_by_uid(struct acpi_device *adev, uint32_t uid)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+#define acpi_dma_simple_xlate NULL
 
 #endif
 
-- 
2.25.1

