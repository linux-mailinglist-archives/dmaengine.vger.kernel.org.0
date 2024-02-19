Return-Path: <dmaengine+bounces-1036-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1259685A255
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 12:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9402809B1
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6A92C84C;
	Mon, 19 Feb 2024 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="GPZTh5MV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C92C68E;
	Mon, 19 Feb 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343174; cv=none; b=Z9yixbfzazsPZjiS826xbUwFoulQ8AF7lYK0yb42zcdzYiPZGCXtJrLRerDVH6f2JQiasZbFIImVl5R/ZnIufGeAfzVwjqFteAINba3YMldJaq8lsub+a7OBRJdeReuhz98j7dt3wUSJi3DbFz7K89EIPNomMVt2AnA3GuNg4y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343174; c=relaxed/simple;
	bh=ZLdHVZJAAAsJKH0nm7DlEteP3dEdil2jcxKBXSOFsXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qbHtkunXVE3f7amQhKojvLE/gWhRMih5n5pl81UkeUvikKFxaUlOGOj5VvEC2CXM7GfXwJb/ELGQ+B7FrTD+X2Sem3S+aBhBcGQTne1bQReqaetq3L4qDCV8JjPZfPDI2DINx9x72zd0zCPp0t9Nq6KqjHDDs1sFEmwFtSoKh4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=GPZTh5MV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso1154952b3a.3;
        Mon, 19 Feb 2024 03:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343172; x=1708947972;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9dBN/g8PVu9zXkbkm1kFd1y636aWTHVivk7klXjspk=;
        b=lukl9hc3BAuLYfkGguA778MNg1vhgRkdycck0QMAGfnlQ9BQC4dBVnnJZIw0Ysiddr
         dz6TRHds0MWm9paP+tn4oTsdU0+cg0+YhGKicdGP8+r7xy/m7fbo1Nob1lOR0C8nuq+C
         +3gpA8ffGNWvsvyQyzoJ+D1FaQRG3Tc+eaLwXbYLdu0DkzehDxR5BeBgNEtoth8JxzBz
         LWfEwTXyKruof2ZAw0XZk3/gyq/hEgKnZiwI4t1O7M0tiTjKfAEkzDD39yzBjjw3ES2u
         keMIxE3oX3AEQucdryeWxji2M1A8fTLamQprcyFsDoUbRssJUiOaAxfu4LI0/YF78ytR
         jUwg==
X-Forwarded-Encrypted: i=1; AJvYcCWiQD1dO95aTPwVqzQoEsBseFw9p+a11ZG5BaLQ2kwaK+uaKxCx8MD4b7535A31kMitnVKrKIPzVUsbSwjVwaZcy1vLgwRoeeJxv38g
X-Gm-Message-State: AOJu0YwUFBgQ/KMw+gFLHhsB4VJLBUogl4RL3W9E5rNjwFfAHP29FmZb
	BxsTs0HtCBNEFOlOrLGHL/8nUTW11kuIQdF0nIdH9h+EWQpOvnJbYbofWmPn0DeEPA==
X-Google-Smtp-Source: AGHT+IHaMvJE3zBOKZBwunmhEb3RzIMNIX9xDRt90aebem4P93dQyK4lpz4lV3/QnnOV1kJ9fUxFVQ==
X-Received: by 2002:aa7:864d:0:b0:6e3:7331:3b7a with SMTP id a13-20020aa7864d000000b006e373313b7amr5795668pfo.27.1708343171966;
        Mon, 19 Feb 2024 03:46:11 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id t4-20020a62d144000000b006e3b868b8b8sm3443384pfl.130.2024.02.19.03.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:46:11 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708343170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f9dBN/g8PVu9zXkbkm1kFd1y636aWTHVivk7klXjspk=;
	b=GPZTh5MVJmleh2ejHnqIvrOSQIsyqR1nUDwQL7roYQUu5r5f89QU3YcGiMdQOTV9ThEaqk
	Vu7IC4Wbs7PRAefKMlRUhBazFOPMhlefLEZtRNbLjQW1ggAuGa/99ENmRpG1k71n1rSt+T
	Cs40UoXBvYqY5IfcmXm/UUlIofptoW9NXWXwAqBKuWZSb6Ajfd1QEeP+azS3IyLbEee30I
	r0osyMevrf6wmEZpbs53s3hd4QlcEUrxspXbJMXqF1pj0wg8F5N5bwIGKuSHAR5Wx8MQTT
	i+dMDBZQuSHVn4mzHbjfG58TWZ86SkGUMwo9VHowjcoFzSSPw3SMIop+4gufVg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 08:46:56 -0300
Subject: [PATCH] dmaengine: idxd: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-dmaengine-v1-1-9f72f3cf3587@marliere.net>
X-B4-Tracking: v=1; b=H4sIAK8/02UC/x2MwQqDMBAFf0X2bCAJveivFJFl84wL7VYSWoTgv
 xt6HJiZRhVFUWkeGhX8tOrHOoRxINnZMpymzhR9fPgYJpe6JFjlBbbv4dKbYVkNDh5bkMA8SaK
 eHwWbnv/1c7muG8Kz7z9qAAAA
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4365; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=ZLdHVZJAAAsJKH0nm7DlEteP3dEdil2jcxKBXSOFsXw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0z+wiyHB1Y74MjkRjbvGpa4OoiWJXWcQ+jCdU
 nmKnUjzOKyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdM/sAAKCRDJC4p8Y4ZY
 pqaHD/9iqbYNVL9ebqauZTuwQB+vd4/KZ68RaPvYmo3yawIRgvHZGGnOh6fhDep5N60uxnnBv6+
 fE1Vj1r/5JbHaxFLopjNSqNTwFpb/rxurKwjuDdjdSrKrjhtXzAsSedshTxS65Tb++5VpfeFvPU
 SA6fvSy9y3REmLRVFgkHDOfsgRXWJxHp6BsgmQ5+//kf/F7GquecvkQ8ZIW+0RfCa9P4MewvoUf
 d/w4+dW0Ah6Ts8BJooZM7wUUoub7VVujEQBMb4NAnc2FuH0DQuWFVMRYws2SMbd/k4koFOChVRj
 jolrAxT2s7Rj33STI6WnzWyk4Wkne3jNrExWBFit2AZXSvuKScoMi692W37IcPaQR3K+KzvTjeW
 iCziYnysSeQylcPcikkJ6FuggivhfBOT3DqqGI5kStkm9h9xmKbeSElnN1SlV582/UM3eSTA25f
 SDgR0ekgTXdlmTVRLPqtpHsTjVjjDSMuH+0KGYGKn876sDIpWd8CVo+sRdFDb8G4VxBCUACn4t/
 vRwk7sqvvRE1I0QZlnQxNAIYCOyPAWuIkWfzjDfBbgT5uLBYvHpCL4TSpPeKFmvDi4sVzN/lGjR
 KUY0uaDfO/BHvvsoUGIWZyn3I5YpOIkypdXp5xe32HV4G4cUblk+h2yNLnHTJ8nmApodDPH+7yb
 iNbqk6+L6ei/QyQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
dsa_device_type, iax_device_type, idxd_wq_device_type, idxd_cdev_file_type,
idxd_cdev_device_type and idxd_group_device_type variables to be constant
structures as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/dma/idxd/cdev.c  |  4 ++--
 drivers/dma/idxd/idxd.h  | 12 ++++++------
 drivers/dma/idxd/sysfs.c | 10 +++++-----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 77f8885cf407..72bb982d7af7 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -152,7 +152,7 @@ static void idxd_file_dev_release(struct device *dev)
 	mutex_unlock(&wq->wq_lock);
 }
 
-static struct device_type idxd_cdev_file_type = {
+static const struct device_type idxd_cdev_file_type = {
 	.name = "idxd_file",
 	.release = idxd_file_dev_release,
 	.groups = cdev_file_attribute_groups,
@@ -169,7 +169,7 @@ static void idxd_cdev_dev_release(struct device *dev)
 	kfree(idxd_cdev);
 }
 
-static struct device_type idxd_cdev_device_type = {
+static const struct device_type idxd_cdev_device_type = {
 	.name = "idxd_cdev",
 	.release = idxd_cdev_dev_release,
 };
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index f14a660a2a34..d8d3611bf79a 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -282,7 +282,7 @@ typedef int (*load_device_defaults_fn_t) (struct idxd_device *idxd);
 struct idxd_driver_data {
 	const char *name_prefix;
 	enum idxd_type type;
-	struct device_type *dev_type;
+	const struct device_type *dev_type;
 	int compl_size;
 	int align;
 	int evl_cr_off;
@@ -520,11 +520,11 @@ extern const struct bus_type dsa_bus_type;
 
 extern bool support_enqcmd;
 extern struct ida idxd_ida;
-extern struct device_type dsa_device_type;
-extern struct device_type iax_device_type;
-extern struct device_type idxd_wq_device_type;
-extern struct device_type idxd_engine_device_type;
-extern struct device_type idxd_group_device_type;
+extern const struct device_type dsa_device_type;
+extern const struct device_type iax_device_type;
+extern const struct device_type idxd_wq_device_type;
+extern const struct device_type idxd_engine_device_type;
+extern const struct device_type idxd_group_device_type;
 
 static inline bool is_dsa_dev(struct idxd_dev *idxd_dev)
 {
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 523ae0dff7d4..7f28f01be672 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -91,7 +91,7 @@ static void idxd_conf_engine_release(struct device *dev)
 	kfree(engine);
 }
 
-struct device_type idxd_engine_device_type = {
+const struct device_type idxd_engine_device_type = {
 	.name = "engine",
 	.release = idxd_conf_engine_release,
 	.groups = idxd_engine_attribute_groups,
@@ -577,7 +577,7 @@ static void idxd_conf_group_release(struct device *dev)
 	kfree(group);
 }
 
-struct device_type idxd_group_device_type = {
+const struct device_type idxd_group_device_type = {
 	.name = "group",
 	.release = idxd_conf_group_release,
 	.groups = idxd_group_attribute_groups,
@@ -1369,7 +1369,7 @@ static void idxd_conf_wq_release(struct device *dev)
 	kfree(wq);
 }
 
-struct device_type idxd_wq_device_type = {
+const struct device_type idxd_wq_device_type = {
 	.name = "wq",
 	.release = idxd_conf_wq_release,
 	.groups = idxd_wq_attribute_groups,
@@ -1798,13 +1798,13 @@ static void idxd_conf_device_release(struct device *dev)
 	kfree(idxd);
 }
 
-struct device_type dsa_device_type = {
+const struct device_type dsa_device_type = {
 	.name = "dsa",
 	.release = idxd_conf_device_release,
 	.groups = idxd_attribute_groups,
 };
 
-struct device_type iax_device_type = {
+const struct device_type iax_device_type = {
 	.name = "iax",
 	.release = idxd_conf_device_release,
 	.groups = idxd_attribute_groups,

---
base-commit: 35b78e2eef2d75c8722bf39d6bd1d89a8e21479e
change-id: 20240219-device_cleanup-dmaengine-e0ef1c1aa9cd

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


