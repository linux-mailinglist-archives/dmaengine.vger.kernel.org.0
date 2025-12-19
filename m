Return-Path: <dmaengine+bounces-7828-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E7CCF536
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 11:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C482C30DD6B7
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 10:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC03D306490;
	Fri, 19 Dec 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FblUbiks";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J87bdN7t"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1AE303C87
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138921; cv=none; b=pM5570ll7qNog5B29rZKQO8jB/YVJG/9fmlYt/f72Rj9+GG2rXrNw+A6RnrO8UeTtMlGp1UelHwCnfqMwcsQ0ZAJfY90cO9TDUyFVpsaAxdNn9WivVJcCqqf3hAKBYinE12l7cRjS+9wJ7Ad8QI2L3+HfD2heDBiq+CXuqEhRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138921; c=relaxed/simple;
	bh=H6RGZzI1m6Hy642I73fornlozWd6x9hkPKo2H6raYsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h162gZ+Au+lfqXypywvpPpoZYIczEOmGodr/ApFDm1zjWBGVNa5jtwtN3qx6NixoKBfTMpFm5vXB7YvkgmW2ZFLpyAoBGJoZackxv6drWDbqP9tM1SrwsjVjXkbII0dp9KOTfSew+4XQIO3scejam75Hx0vHXfhyAo3+Sea2Ics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FblUbiks; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J87bdN7t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4c0Jq4145308
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DQ9O/WxlrEXbsvKUWZga3GBiGSWqxH7TMX/h6DSnlY8=; b=FblUbiksDdOT6ybC
	0eFMd8FZPiQC1MNzvNl0gINkd03cAer4YZ3VDYH6Qp/KIeOKp87DQRyRcMBHn8Se
	6xEsfWd38BtmAtbA/vR6kHzZw8eknmT8ycBjFZNTyk2zPTCAjrKMTFvSKQOyfyTz
	8GmGmJnIl5vxodjlvfpDszkHG9lCuntckx4hdwg4cbm62csSDDUqn7dH1psnJbGB
	plMnJzq/ngYmMsQi6UPw5kXjudYO9axYaldM+YUCsDZiNe5we/ok3VvX0806ysXZ
	xGGLy+4gligIZbBSYWG3rqrjzqmkbDRgZGRQVOTReT7s5tx/ZWSFplGtcjl7XQeA
	TQIzVQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2dt944-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee0c1d1b36so53745921cf.0
        for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 02:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766138917; x=1766743717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQ9O/WxlrEXbsvKUWZga3GBiGSWqxH7TMX/h6DSnlY8=;
        b=J87bdN7t6xKkW4I8NyKQ9PIhP6mScQfjV+3kKr66HycsjhUOQIOri3pP655VUt2o5n
         Bflm42aVKAdNYUaWyc90oIurZX28QZJ3tRCe5EIJkwbH8gOO41VTEFsV8bN8wRQjezKl
         B3TyE2zlr2PBlnAWdZKD0nSdcGPpazSc93coe2xgTmSFP1Pvj8dXmyGKjIkRNmzlG0dF
         C+x064FedWORFoLRypSycY2fnlYXAIgoSgeew/6+9rTq1tgmU6E1wWwyCAsDVltyTmNR
         l29q0Gl1KMfYA0O68FMfeo59bnKYPJJMkT98Uobktq9Ggt3k21aOCUsNyzbjygJ7U3Ss
         iiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766138917; x=1766743717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DQ9O/WxlrEXbsvKUWZga3GBiGSWqxH7TMX/h6DSnlY8=;
        b=UxAe3lT/Dv49OUJq09+IQmWvPB6duiMh9y963seaU2EkiZ3y3gW2xbxrcoka7dgMB9
         UqpzSMDwWFsPJAieq0MyBHGhLsNnXgnot8f4USRrVJq0lTIOyRbT/pGb8luOOpcgvbJN
         2gUaieN/pNJefsUSfqD9afPbT2mHct8yYmY60RiM3Q5jOac+jR2Yj6w9FCShN9tfKmRc
         4N5vEfzesGskHkQm/Ta8WYxpmoCg78SJ3qzOc1Kxh7yNexxIDVXjmPs4vA5MNsMARGJI
         Oo6gYRPBEAI+k+ycZW5wSneMywN3mlGvwwVYl4VWSftLQn6JiKWf4EzA34yDK00QdfqM
         7c1Q==
X-Gm-Message-State: AOJu0YxsGky7N5PN6dW3YsGwMeI4RZFUvhFYaoSwlH7qKW8jAd1xu0Ra
	eItk0cTkxE+GoYpLBXXCVraZWAkCn9cut0pLZltwiB+Y0Kv5K4r5rhkZ5RsiBYxB1GnyDonl+fT
	29UDF0Ld5MwMyPLfuAVbC9f2hC3oI6bV9k5dRri7HLtdUfZ2l3I4D+q8NmZEX1Kw=
X-Gm-Gg: AY/fxX5gOBwfdvcIXGl/CkC9NoE2aD2SjRPtPNCddrUhX8Xend8ZH2HdFnXq0ezXH9s
	1+j1eOo/7qcMZwusjZDvlUI/ghvUpuxh928mp5Ekx7jMNm0Y3dZZyXKmZ7oFc6+3LCWMJ3Ka1d/
	CtzhAqUZWgJOQ5GkEyV6dnAYgnrF4k4sLqapqQ3g7+g1ytr5JPuGDrNIkfSAiVugz/v+wLB08+v
	LGXCNslHCMns1PUEjUnnzg5PGmOu3yAJkIJW+bUQxXpt6hQbwthgXeDel+GQHi7rdo1/H3dBsA2
	G4ECJWzgH5hSreiuA6HZEnGughLnYW71+BRhicRCz3VJASSg5KyyHUJDG1buBeXbhmNlXK+VN0c
	2m/bUPlwQf1j0oQYvqE1BqElFhLrWq93k03dzyQ==
X-Received: by 2002:ac8:5f8e:0:b0:4f1:bd60:eb7d with SMTP id d75a77b69052e-4f35f3a0f1dmr74754721cf.1.1766138916738;
        Fri, 19 Dec 2025 02:08:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3KPEegnMuKT75tg6XjQJTnbgPfXlp5ec6OVQCeKcX2ems3nTyFKNO6BdQDvZWNhuFnoUV5w==
X-Received: by 2002:ac8:5f8e:0:b0:4f1:bd60:eb7d with SMTP id d75a77b69052e-4f35f3a0f1dmr74754551cf.1.1766138916340;
        Fri, 19 Dec 2025 02:08:36 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:a48:678b:dad2:b2eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82f6asm4209571f8f.27.2025.12.19.02.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 02:08:35 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 11:07:46 +0100
Subject: [PATCH v10 07/12] crypto: qce - Simplify arguments of
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-qcom-qce-cmd-descr-v10-7-ff7e4bf7dad4@oss.qualcomm.com>
References: <20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7dad4@oss.qualcomm.com>
In-Reply-To: <20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7dad4@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2620;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=TfRVgyaOMZw2GJQ0rx6WhRl0huHGm4mvuAmz76BcVUM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpRSQUTzmSGLFyrlG2gEZOV46m/aXCFMmi/dETO
 y9XVLzl7a2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaUUkFAAKCRAFnS7L/zaE
 wwubD/4pvTivO1ePmCtJUdSnGlI1Y295t5L5NP4cseSIqIWmOvUk6OR31ukM+4U6a2uyw33CL8N
 x46pBMvqf3dk99TNSzqsweJdYITYtYNiHv35f+/Yjo84hL61azE2qcrKuKPZTgMgzebKIGqC5FG
 LxOmE23qmKuJZZXfW5RDc7wNd9PWswydsAeH++Pyl9wPmuiwgLDKPaR0jJANiFSb/MoorrsPx/u
 MFxFlTCQPDkdq038laMZnoJjEWW5mFtwu3H8rNckqPAlrQqbkn3OLCZmFzIarv/hhV3M2Hh8Q17
 WYnfprGleqa2vbJp0WFdPp69hQSTE/LXo3lpqenRLxRgyuqAnmKps1L44kWepRpnXXaRZzr8Fsz
 L8jsdHcuJA+rSiU2KGfDZgPgNfHmbMUgPHuHqc2nPwj3bWgn4tx1m39uaTobEKD3mBrs+7HDKvt
 rtR223K+FYfkO7G+hCKKJlhGOUtG0WL0wtroFkK7lfiCQGwUhw3mUGkdkkX6UWlp4U4lkkm23KE
 wMC+uJoHqxNSSXCnVuPrMR2VpG+T9+PJZoL2cfN2D4Mg9jku3vnJ0coxe9h9747DrL8uvX9x+p7
 ho44htD8gWdrzYQYR8o67RyLFPKMvtWeHSM52kCeUFspOS9m9muUlwZ1T1+G3tWJBxo/GSvZ+aJ
 fHmpKPKfJq+71OA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: tHV0lfkUviSsmxG0fzKP6fEUK6VaVZ6w
X-Authority-Analysis: v=2.4 cv=A7ph/qWG c=1 sm=1 tr=0 ts=69452425 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=KrkfD191a8oFwBap4LAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tHV0lfkUviSsmxG0fzKP6fEUK6VaVZ6w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4MyBTYWx0ZWRfX6/Qo5yMxd3X8
 fX2fFeSVl8pznXvGt+Q2LufcJZdYFQsmu79jrynEaXhaQSfvPPk/VwZh1zoAennqVFztleGkN/7
 v5E0lG/x3e2oAQ2QQhiPOYK3wIGUo3Te0llJBiDdw4Lk9x6tjqCSGfuF6QscGPkAmChVIee6G3L
 0qHJzME4aNj2Fs5wrpPY9t2IKSPXrK202Dq6v3NzNacobSVstZqBFuP9b5hmJzD44e8WjxJX/Ve
 SQz/WWqs9KSDrKkRGcyf014GIkgt4WtNn7Hzs9gbrkyeeXI/vAlD+Rc70X2BalUmCZQXJFV5ijE
 p/cXzFPDTaIZEUwHyAfVSG3le2+cWVAWzM8BE26Dtka9gpYCKaua1rrc/s0b7HUPeghWz+l+8Br
 6xrz4IflNLMNhgz40q1UJDYjvGNAe3aZK+5iOlu2bh320VHa9yLW4v7QfLAGZ8v2yXv1DWbF/7L
 IqyVREO9hZVlm7fkMRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190083

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This function can extract all the information it needs from struct
qce_device alone so simplify its arguments. This is done in preparation
for adding support for register I/O over DMA which will require
accessing even more fields from struct qce_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 2 +-
 drivers/crypto/qce/dma.c  | 5 ++++-
 drivers/crypto/qce/dma.h  | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 65205100c3df961ffaa4b7bc9e217e8d3e08ed57..8b7bcd0c420c45caf8b29e5455e0f384fd5c5616 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -226,7 +226,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_qce_dma_request(qce->dev, &qce->dma);
+	ret = devm_qce_dma_request(qce);
 	if (ret)
 		return ret;
 
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 08bf3e8ec12433c1a8ee17003f3487e41b7329e4..c29b0abe9445381a019e0447d30acfd7319d5c1f 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -7,6 +7,7 @@
 #include <linux/dmaengine.h>
 #include <crypto/scatterwalk.h>
 
+#include "core.h"
 #include "dma.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
@@ -20,8 +21,10 @@ static void qce_dma_release(void *data)
 	kfree(dma->result_buf);
 }
 
-int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
+int devm_qce_dma_request(struct qce_device *qce)
 {
+	struct qce_dma_data *dma = &qce->dma;
+	struct device *dev = qce->dev;
 	int ret;
 
 	dma->txchan = dma_request_chan(dev, "tx");
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index fc337c435cd14917bdfb99febcf9119275afdeba..483789d9fa98e79d1283de8297bf2fc2a773f3a7 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -8,6 +8,8 @@
 
 #include <linux/dmaengine.h>
 
+struct qce_device;
+
 /* maximum data transfer block size between BAM and CE */
 #define QCE_BAM_BURST_SIZE		64
 
@@ -32,7 +34,7 @@ struct qce_dma_data {
 	struct qce_result_dump *result_buf;
 };
 
-int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);
+int devm_qce_dma_request(struct qce_device *qce);
 int qce_dma_prep_sgs(struct qce_dma_data *dma, struct scatterlist *sg_in,
 		     int in_ents, struct scatterlist *sg_out, int out_ents,
 		     dma_async_tx_callback cb, void *cb_param);

-- 
2.47.3


