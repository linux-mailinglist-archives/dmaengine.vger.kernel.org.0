Return-Path: <dmaengine+bounces-10744-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANpMEFViEGphWwYAu9opvQ
	(envelope-from <dmaengine+bounces-10744-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:04:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8195B5C87
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C351F30B78FC
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7A1472774;
	Fri, 22 May 2026 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q7a7As0i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uys/B9Jz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D446AF15
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457258; cv=none; b=JPVWs+CcmQW5sul3ylRBlpFo6bWNNautw33+IrJIZdFsTf6L1xUDFZDdDP7dK+mB/uLbxFIL688GxBocMHnfByXTAjWsHcsD1bpc+CnVin3AeJLCnhhz+OA2Cdis8phrliYz0NDpXbmOQQC48zQJJrMYBhogXNgPNhEPPDAsLk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457258; c=relaxed/simple;
	bh=itwan/+JcxMJcmRkoZRAIh//GowjNEJ5Pa8ZGTWCN4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYf9LkSHxA+dRB/9JiU+HNhljTJ2hdlLUPNxTDbcGuAel0YfySskHn4CXVKuT9k0zBCmMV+MIIHtWwCUybbXCl18lcoZ34luHy7EObCA0faiOM8jcf/pLQpDgNv6nDRIRUhjNYKi+5t6PgpoxybqqiRgJHN2NnX5s/+zytY701k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q7a7As0i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uys/B9Jz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MC1u5p779268
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	okZRx7JveDxwd/GUmOqQGeY1v3DjRixvo9jJJu0R/N8=; b=Q7a7As0iUCihXzSA
	8DGEcg1wkTEXjLgkvMc/oQTcpocWg2Y6iCWPvnVPcQmYL+Vzmd3Lka7M067AfUNY
	3klcagQsEd46KlTw5tGan/RrtdMgZbtOayMXBw5oEJOJbZ+Lb4odNzBf6yRq5TVS
	Xw2x7BmMgVqOlh/xcp4ICszPH0OabjiLTIjaEoq3DAWnkKRgd4yDFW8nJIIjG2Ol
	SJKYoxcuw2MbSHO74FKtkCUDT7cI51p1eiKmxWtE1mNAlGxFRKQKA9xYLFSz7e+j
	Qh1GWrqqkbiUp7VhMo1LwakZfur/gJhHvzOKxOuwBj8PyNstpM8UfiRxyvvsgf0T
	5/F8rg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7aty1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50fb3403e99so82513041cf.2
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779457248; x=1780062048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okZRx7JveDxwd/GUmOqQGeY1v3DjRixvo9jJJu0R/N8=;
        b=Uys/B9JzJNDQMyYbeqPSEf/yLwYzK27Ts2/yPBW4sOt384FpBgPdTJAa2Kn1vyyC10
         lVk5WF/WHq38ivIEDq80ISPo1pO4bbVk6sTn6CKnQGFrcdMkF9r7L9nbV7qJIEDDfXm3
         KgBg/FKQ/mdZ8y5kYZIw/DjtfK7Gt27HKbD0LCBGVWTAQpHO+dkpuyqABG9FFabpokOt
         mGqcO+GUSSg5PxAFDfuNqvORvC1SvS5tuBojVOkQ3fSQDNMn+ZafNdH/+EuFCPgiS6uj
         JwUFYqBqNnkbD1mAT8PmiET96WMrRBN4m38RLJ1oKrJd2Lg5Et5I4ic3Tz8VKIDcOgMA
         TP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457248; x=1780062048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=okZRx7JveDxwd/GUmOqQGeY1v3DjRixvo9jJJu0R/N8=;
        b=KFrLHs/tn0lyhZ49ooRhjuTMLBhGW/rLXDFdNa7xUQ8J15fwdc5FiKuqcFvoolLY1D
         nm6DrBCI7Xieg24x2YstdQD1C8X+nIYOD/Wh5ENVyY6Zsrlol9bLWnqlRAA2MedhCqMV
         jS08+ZxF3pYynsC35WMFMtVrLh3s4sCDcdtLkcdAgJIdjbhvlTN6xE+ryGVovOVBnmW/
         bbR4MIku9lDQ13nisNYtzqh2TKRWkOnu35AwCA3NMQqhy18U+dpdX/qwyiqde0nmcybx
         tanwTtI2cozfI1qWISb8h/nSgB3R7NQnGcqi9GM4Wd67lIVKiipCblbXMas1eA0VskJI
         F7ig==
X-Gm-Message-State: AOJu0YyKUXlxN+QIA18jTXhZql7hPxATa2coaM6qO7Yec7Si1sH1/i/g
	x6LMv7qY+2lYZGT5XdzBdN/C8LV2Jyj44IZiYOgbo/T1RHjcLU5wClrRAkAfAAWPUVI2VsPHxma
	xUP+HdTczyQx5xx9ZuA0RUfV6GpzS+UiO3E824C6S6T0Ql0u224dhR3f8v2vjDVg=
X-Gm-Gg: Acq92OGM2FJIBg+ACobMDemRpvZyXnW/CreuQQcOTsUyo3e67MjHNIXOZWr2OCdyimu
	Dbve85N+U/EKTB9FG3XEOkOov2yB8D7VpRxqhe9D9SY/MLwkx3gUfQGQaO0vdU/hq0BZuPjBBnO
	7u2PyKF43DLjd5Y/uNgmcZcvDBGXVTjy138Iul77pfPGFEaiIxvVQS5ltONqWZdT5L8nEG4ksu7
	rNXWNmYAbWj2xhDuCUeddWaxzAbQalfyOqYzjDUKTayfUKmMHAMPHvFavfuhRaMIJfM/rk5ojeG
	UIM2Nw3VCJ3D6Q9mHKzpmedBxRUolwhrvm6wX+1b3QNAA6FQT+oPkj6cBurXdroFUnYYdLa84Un
	m/j9vwwq0VSZeVlohsxkLp0rex3d2Y77ErPuGt4izKtXjcFSJRA==
X-Received: by 2002:a05:622a:244e:b0:516:d66e:7b1c with SMTP id d75a77b69052e-516d66ec02fmr41104401cf.34.1779457247595;
        Fri, 22 May 2026 06:40:47 -0700 (PDT)
X-Received: by 2002:a05:622a:244e:b0:516:d66e:7b1c with SMTP id d75a77b69052e-516d66ec02fmr41103961cf.34.1779457247161;
        Fri, 22 May 2026 06:40:47 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:2fa:6280:a48f:fb37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c600esm44912825e9.3.2026.05.22.06.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:40:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:40:07 +0200
Subject: [PATCH v18 14/14] crypto: qce - Communicate the base physical
 address to the dmaengine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-qcom-qce-cmd-descr-v18-14-99103926bafc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=itwan/+JcxMJcmRkoZRAIh//GowjNEJ5Pa8ZGTWCN4E=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqEFy+1JVvwHaZ9qMXejO19SIcCtwjcWfi4iqrs
 Snxz+YI1+SJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahBcvgAKCRAFnS7L/zaE
 w55lD/9VdqXY5+AwSFtZGtFpvgU3LLl/oCf44IozAmHB4mPzRC4szaMIC2z5hyHEGRz8pCNIr2M
 Mbg2KnLvgf4gOx0zV09lH0jpN/l3xD6O3KPrk0KKG1bSHejWM7BbQpU/2itE7chaZCpq/q8CqTK
 nZV5GzNfZJogVF8S8LiBXONsIvsilt37tvmtaljNrc6YLvkYDmY2h4pzeAzte1PpOV4uV693uHo
 yGYsy65NYMgUvk2/adSg80xBGO4YGkAjpk1QF40eiGNlIs3rgCkpe8TA6ymm7j/AVmmjk79s4SR
 8aI+N0zDj4+SLkPE3xdCqca7eu7pP6Jp5PA9lF+/CpHSo+2QdGxJdNEh/N93w4zwY7La09+9xLK
 o5PL4egztSZFRjx3kPlda9M4PoQRTRlunJNgPFOW1ffQi2kHm18aERxpWHVPCSOOlgHX+XIAHL9
 gHgQGB/HpShlJHLvKbTjI5o1fm42K2KHeqDf88Son/Y8GCnpm2geSa39HiB5m6MsGiTd7txCqyz
 OnoFKiWEd/Ojmrf/dJjXGpRhcaSWRsCOyQzaNGxgnetfP4ORDpp9Vbp+HB3flEhm7LdBd3YMv9/
 pwZc/5MWcs5cnysXSUZ1vc6vf7mD1ZrevQPcs5ayprFaJ3vHg/b+1zUQQlAziNSsky/vBK10bUu
 EE7+gbmtqVy/41A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 7DVCs3KCqmwx5KII7nBLzQKWMSlfSZly
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a105ce0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TFgmKHP77OfOvYwKDSoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 7DVCs3KCqmwx5KII7nBLzQKWMSlfSZly
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzNiBTYWx0ZWRfXzmS2kFtb6Z1B
 ZlX+2NDgzBJXo/qg3Rz3l30C3R12SJljzhJmZxTdBkR41nbP5k9CCgECBX2jnByAmAIiEMDmpic
 ttgZspraQCqOvkzaccC8hotFyC0VfQbwDvTxtYKAkOWS/OWErWEUAUD6KR7ifyet2WAgmVePfN9
 g+XsmF8RwvISOH7mRdTmRnDvi7p4X9725WJadNBhy3/xlsNDiigceaXrAzaoX65+23llRFVE3BC
 tF+Q7byHe0NnnR0ojMek9qgCjxMvw5wdAEhGV5R+26HoxuRUIXYBqp9lZmpXFeagyOYHY1inw/A
 LPn91vn+c3L25eOJkO4j0UmtWgnqFPmHZE69Vy/FvEQi9wUpOiz+KUgXihbtmCusWsehX2JriLj
 vkhLAbeSRLlFBpIanPd2upQKQ7C6HNl6aFO8u7wDZ5g63nc1nJ5m3M8+0HGXMHIOqpPkiY/8D3h
 14XFjJfyWRyJ5EPs/Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220136
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10744-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: CF8195B5C87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to communicate to the BAM DMA engine which address should be
used as a scratchpad for dummy writes related to BAM pipe locking,
fill out and attach the provided metadata struct to the descriptor.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 437314f2aa94feee765f750304a28ed7beca90b0..f7a7b98d843f03b7a2722df0376a7be6b4a09114 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -11,6 +11,7 @@
 
 #include "core.h"
 #include "dma.h"
+#include "regs-v5.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 #define QCE_BAM_CMD_SGL_SIZE		128
@@ -41,6 +42,10 @@ void qce_clear_bam_transaction(struct qce_device *qce)
 
 int qce_submit_cmd_desc(struct qce_device *qce)
 {
+	struct bam_desc_metadata meta = {
+		.scratchpad_addr = qce->base_phys + REG_VERSION,
+		.direction = DMA_MEM_TO_DEV,
+	};
 	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
 	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
 	struct dma_async_tx_descriptor *dma_desc;
@@ -60,6 +65,10 @@ int qce_submit_cmd_desc(struct qce_device *qce)
 		goto err_unmap_sg;
 	}
 
+	ret = dmaengine_desc_attach_metadata(dma_desc, &meta, sizeof(meta));
+	if (ret)
+		goto err_unmap_sg;
+
 	qce_desc->dma_desc = dma_desc;
 	cookie = dmaengine_submit(qce_desc->dma_desc);
 

-- 
2.47.3


