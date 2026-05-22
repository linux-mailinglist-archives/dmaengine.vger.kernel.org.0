Return-Path: <dmaengine+bounces-10738-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA4EAW9gEGobWwYAu9opvQ
	(envelope-from <dmaengine+bounces-10738-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 15:55:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BBD5B59EB
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 15:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF47306CC60
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 13:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712A44DB7B;
	Fri, 22 May 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hFm1zlHV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iMDIhkNr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409EE43DA56
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457240; cv=none; b=f4ok2cRw7R29DrJsFxY2ynjKLc+uiWEp+S0oJ9TXezGFTKSbyvhMFgbkU8pBj3bUm/lWpoKmNwpHCI668KoU98d3pLPdwRonkTTsc5xBy5Dk0/czlDxPFpxB/3tMs8kTrzdIZK+2g6dVBpgp0FgtM/BADa75ak3fJaPZ10poZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457240; c=relaxed/simple;
	bh=bxwOj+1r4hE0BIdCr6O2vUvIE65d0GfBKW7+Xew4ns0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEpC06F3u8V40KzkYWuq1Ckc/Fjg1gOu62Hv91MzmBhWEdcapoDCclaiAGZUhW6ne/RTOb1snNouekRECAjXxXrtP2+DOLP3K2JaGntMiq1HAqOmvttHGW2BdcZZoMom+1xaUbm2H9mMzkI8XKdZjalQe06P3TJaLhqRbUGQOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hFm1zlHV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iMDIhkNr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M99THQ2765104
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0kLuBmycbMAXm5ws7TG+DllfddsRIfX83CGKYC8vsgk=; b=hFm1zlHV59sE12if
	pH8nBKLuhP6tWQZ0fP7EK7qHeZMHzzVSn65kEsR3gU/057Gti5OwtXpDrMq9fm9y
	TluGSxSuzgq2UOdFUtwxn31I8KMEjnGq5rbycHpvhIlAyfLSPulmXS9GzaOkyz+S
	wdU9TKltnzwoyBPKJFxwG8+mc/pOhfjBR4pFYT9vzh/pz3B5Ip+1RpEtlCf34rHa
	EZpl0mYsufGeMNgd17FHUuo7PsQlzB4k7eVilvJU+M9sLOq3wh/pOkPpH4cszi2f
	NkZo6Sun0lWJus0/deIkBPx/CNeUsq0zduFkQsrf+x4/2hNbdwXeu5K0d/Jz7qj0
	ofdc0w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea3u7w65s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:35 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8acaea1ffe7so217958246d6.2
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779457235; x=1780062035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kLuBmycbMAXm5ws7TG+DllfddsRIfX83CGKYC8vsgk=;
        b=iMDIhkNrs7zwWiTWV9K93dC9SFDj3tYoFSzGcwvSLQloqSTisitZQa68CgeBodJifj
         bn9e3AnBJ0alYv9Pbh/jY+jSTDaiFspQ2w8bhDOUQolXO0oVpV8hFhpUwdATTo4RFbJA
         +nmKTf1pGtJ9HweHms7ZrPnnFoLard7/+cWD6MFlOr1XcK6pabFm0j4THrBLOSZa9yDd
         epb9ZmW+l709lydwE8GvDZj2af2r6KZjI4/5bZmP6eEPkDd7oSRLgd7MeFPaDzZTBTJG
         EiiJ+KEZK6g1pa2rN04n5YoHEeonccbHNVhlRmx+/TIfmrRNqknvAmw/i5tbEnJsZibx
         gudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457235; x=1780062035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0kLuBmycbMAXm5ws7TG+DllfddsRIfX83CGKYC8vsgk=;
        b=QlY87Gq28zENNFRECODXMC9kHeZvVBuZAvYWhTN4uGdS2XywS5B3yPqWm3HGa6dBOe
         oUkLXyBGXnpB4QklCWSspTse/BsRyRe53Me/0vtA4djayojbqCdEKth+lubpBHuu0GDs
         EVywG7Pbz2nvls9WCz5jPFtJWQ+M4JhJkEwqUZc9nvtK8ztweMN8aJpvuLLUpZTVaYwi
         gsQoGF1FMcy/MHclEw4m6q79qMqV2pFbjjWalSt53eC7xTXMGgb+PWMkHbRiuw326VWU
         Co9N81JOSXaxQLotLvp++OmWhbt4rh2x1plG9wpr94/ZNz+j9Qh50l5W9TeXVpo+S5Na
         CChQ==
X-Gm-Message-State: AOJu0YwHu7eUQP2S3YjaaoTevNopbyyYkql/Wl2Gns7IdfWRC/sZZXlF
	1XoD0hHFZnkKoFKFKlhBQqzia9Q+zrjtEg6tRmGQkjpC9fp+zAGCQAzgYORv6TIdLPo+q8nfokD
	rJcSkhIRyZNJqg5BT6pr7HGxe0o5UNzZZGB/4rkw/J9lH2L6+SmK8HYccF8eYlT0=
X-Gm-Gg: Acq92OG+7trPcPAFi6qNvb566D4hhc1WMwMR8e1rErQT+15u3t4NA3AApuvn8+UhyGZ
	H5vYMqO9iQnuvm/RlVPVUkZt7jDx8kY+1ZSR/8h480aiXCvjLVAbhDKaFy2dSIyTP/ZTL9THc4n
	w6c29BuX3nIMRLPD4Huhk3pJz2IoAyMO8lZy1n59mW1KiQ/mNxsYbN3twprLF/ney79+tk4eT+u
	sUYz3EsfynXQHCEjANqEyAjkOwk2xbsJXiy0zFLVnH0zosk7rz8Leta4wZU21UQoy5ZcNehl5QW
	0ltftq3SzY8FP5/RHmWtuIsj43V715SK6CHZLS9CJjlob1LMo5X6dT3r5A9QHSuxI5BOWOh03KN
	QuYpRc+HsGxby3jk4Tk+DkEc4DwHfvd7pWzAAEfr/PVuNK0p0G75PuyCw5/xf
X-Received: by 2002:a05:622a:446:b0:516:db5d:ebf6 with SMTP id d75a77b69052e-516db5e07aemr19429701cf.59.1779457235472;
        Fri, 22 May 2026 06:40:35 -0700 (PDT)
X-Received: by 2002:a05:622a:446:b0:516:db5d:ebf6 with SMTP id d75a77b69052e-516db5e07aemr19429081cf.59.1779457235055;
        Fri, 22 May 2026 06:40:35 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:2fa:6280:a48f:fb37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c600esm44912825e9.3.2026.05.22.06.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:40:34 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:40:01 +0200
Subject: [PATCH v18 08/14] crypto: qce - Include algapi.h in the core.h
 header
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-qcom-qce-cmd-descr-v18-8-99103926bafc@oss.qualcomm.com>
References: <20260522-qcom-qce-cmd-descr-v18-0-99103926bafc@oss.qualcomm.com>
In-Reply-To: <20260522-qcom-qce-cmd-descr-v18-0-99103926bafc@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Qxst61jdIT+8Ht+en2AytpIG+5WhKs6TgGXh9cEYbqk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqEFy6BGklBaP1lW8n9Q0gaQ++0gYBLLHAPfPUj
 Pn6QDYsHf2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahBcugAKCRAFnS7L/zaE
 w21JD/4iKA4zWq1eo8131QpnLuCtj0jhM/ZelDuhM9ibrZfv91X7S4xQ1LFEKU0g7zq9/dfmIbo
 QBDd0DRHFHuoxjwJF47NHYwHeQsnWtuQaanIlkITMdxltp4vjT9NSZN1ls1mk/KdfUBwdGg7q9t
 odm2ClpGr/UxBis3w/Dmqp0jox/D5T0YFE4xxzEkLWnIsjSFvo4lH/mL8IQbyH/uBOC0T8fNdu3
 2YyixuTnTC/Wr+lHT37sthmfP1J8vUL+l3Pog8Os3LTz+UVeLaM4xaOEmPgQwldLjsRxYtjujGt
 ID6a/vSU3AgusypMEuPexklUuxUba/4SohLgBW11Jg4CrgFFTt1CBwa3nJx4w9H38K4jxBBdAEA
 nFADhoYg9ISvEbMutcACZbTrtaGNrhwkx9l3HliHrhVGJAX3FMBdwVxHnrv8EAK2ljpfI5eHSnB
 pAcmC10IlfcpBUq+BpOCy5PqEVWxEzp68go8jdiAux6NC00i/izE2baJBjQUOx+YNevTECGPsoh
 OpbDGgsNqfYck1Za/oVuXor6E/pQ3woJioHCcybDuCQB/tty24iWhvjLZAGoaDALiFVrsMe6kN/
 SZw/Yz/aJM9+eicofXDvybZpmUadpzf+RC0QQxcpuCIiIZCEYzZZaDt+N9c9sNIDvfRCw3IJyi4
 tVBYEj1xMmvK2dA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=aIXAb79m c=1 sm=1 tr=0 ts=6a105cd4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rvG61WhHFVBzVmnuldcA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 1WqYJ8Ns4xbeGp5yWLu6J3XTgzDgF4tj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzNiBTYWx0ZWRfX3RHpfD0aq3Gk
 mxRteh6izP7N43G5S9HR0jh9hBaRwr+UyBC9T5UQayKFJAgy7z08mwyGg6wEzTHP5F3selRZeYl
 Ux4ewj0To/2AFAbvZoIAuUMvULSvlsicGCwTwEJRXrF4gt2l/EW3vVFwku70hpc2yWsjqscEeNY
 qmONKcfjm+K67uAFBD1C0HcDcucZFbUSG0ASmrGWd2dtBcmK904smgZvGOWecB2rXd3/aqyZJkN
 7i99vIWpZ+qke2xSdnHY+YTbGE5uLxIVbPSQcbed70oCA5HDm/tCnsOpDEKj/iN1jgSiAdGJ831
 BOn+kPCCrpN88pVe/iCKMK9Y4eJrSQPyDXUETt5w9+ffceb4+t84PE0grVAKIKg5BaOrjDZWWYC
 8/1FUEl8+cOLTpBmFje2ZPmAlESr/36NQMLKnYVNj742yVwW8oeJsqnp+NjWzFgvfzp2Jwe5tsA
 u+kOWCZSw1+3423/X6Q==
X-Proofpoint-ORIG-GUID: 1WqYJ8Ns4xbeGp5yWLu6J3XTgzDgF4tj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220136
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10738-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 90BBD5B59EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The header defines a struct embedding struct crypto_queue whose size
needs to be known and which is defined in crypto/algapi.h. Move the
inclusion from core.c to core.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 1 -
 drivers/crypto/qce/core.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index f671946cf7351cd5f0c319909bafd87e3af701c7..ad37c2b8ae53a373bb248aff06c3b7946e8439a8 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -13,7 +13,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
-#include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
 
 #include "core.h"
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index eb6fa7a8b64a81daf9ad5304a3ae4e5e597a70b8..f092ce2d3b04a936a37805c20ac5ba78d8fdd2df 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -8,6 +8,7 @@
 
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
+#include <crypto/algapi.h>
 
 #include "dma.h"
 

-- 
2.47.3


