Return-Path: <dmaengine+bounces-9610-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKY9CK9jwWmaSgQAu9opvQ
	(envelope-from <dmaengine+bounces-9610-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 17:00:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBA2F73F4
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 17:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 859F830926FE
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA13C7DFC;
	Mon, 23 Mar 2026 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O8rk/zpX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kS7nsUgk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E023C73F6
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279086; cv=none; b=k8A9Nl1N68qdRzo0enCwBIZTX5LjYcZlU4IzujdpxEKyRfz2wogbSbQ2gJMUn2rthbQU0eWmVW2YnarqiyTR1oqKCijgg/YGIeF/9yHI6m09Mv1uBiIKqu4gqpc2ju3Bl216n2idap563DD8FGesZJoA7DW68ySBTC8WmikgQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279086; c=relaxed/simple;
	bh=zaDjliGI9P8SDSmb8oK5ZUowNY4iBaNue5t3+i0OgLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bPlZDOIQxDBDlKatETmX2yVhAy23RiH8QS/JKUmIW8rLNqGSBXAC5VRtE6Z1pdDGi/O6qZF6zDP2Avb94bSNaNpz3fz2Cpfa4EAfDYoT8+RaBX2rw4x/2TPRj47/GUTTDR9ZjVEFDCjXR36PlJ/I5uhrK/8GOanbSP2w+Y4b7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O8rk/zpX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kS7nsUgk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGSUr1473571
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nLZDYW56A6RoHAFTzDl5i+KhZW9amsZPLqs+n6djD5w=; b=O8rk/zpXpgJ6xfFB
	gKetOgIHP2LnO3VSBUuiW+IwSQK2TF3wiJ38ea9sLr4KyDr6AiLzDfmdMDASS4fN
	rcbef5GSJ9EJpTQhTltG0GgV92y9nHXxhS/NIvzrlcDze15JiLEa2+QnP8acKidg
	wH2uMuDrdCbjmhThpp2SYzI6mrT/tQVZ8SXQYOdUKRrBwiKxPbakwMWKXnFiG2zU
	EJ49vFFUcnF0dI/NoJf7EtI4Wsd9sdjn/pNSGreHQp6GyYx7gZ1ojoR5I4gXQqf+
	Y5qtiseXTgjAM8x01WSGCz8joxgejGsi8LUUgNXaRIQwbsueC70EO8BJh3Sb2/QB
	GF/aGg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d2ca8kwh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:18:04 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6028039f3e0so1802656137.2
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279084; x=1774883884; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLZDYW56A6RoHAFTzDl5i+KhZW9amsZPLqs+n6djD5w=;
        b=kS7nsUgkky4iV43ANBPqGawYOGNeQi5hivIcTrAD/SnduHmY3LtEu4hUA3opkC+KIQ
         I23eqOnFCJBZJRIM45x4Sn1lW8ON+MY3geHbnS17oKAW9z4wqXGGE24NcIfcnUGUFdFY
         G5/UZdu8Md7ZdLe8Obmy7rQazfhO5pB4/MpfKoxK+Sr+cQPqqdIM9i5zGS6MI5jJGlHp
         +OCt0P2h73+QEy4xCf07W5dXhofHMFZCI4S/I/5YfmJH1zvMAbvikHaTxuoDdhkQYNco
         X3ouTcoLXQj6GICWu5sT/WLln/8a4HF1BDo/I40wrs87682v1L9IZCr+B6VQw8kVAqRA
         2D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279084; x=1774883884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nLZDYW56A6RoHAFTzDl5i+KhZW9amsZPLqs+n6djD5w=;
        b=OttN6JlvUuD9iBPL+x75DK9AQmS6s10ldHVGlTvmwrD8c4vleCKEaEsTSRt8mOZBGb
         HYaHSFZftq27clzB3eGaD9P2nZaIwwiW2urKZplGFoSLljwhbhBhqGdPx4+VsfldHceq
         VZ2qxwkmjgLLdQvHhn/PFedjqaPLo2ECdRTR5fqWzePH3qs9Ur1C4ifVGbDNjmfQLP7f
         h0BMZhROAUmxn6WEYFu2Y7MKyGQZv6c4ZTMDoGGgEE3fCEwVALKivFFTDfdBpaMA54vV
         XPFPcXK1qB4g8HZTqhSm0q/k/f3Lh9qR+KNhXbPu8ST8SFqJ9GfNkOraXiVpblL/RUr6
         YRAg==
X-Gm-Message-State: AOJu0Yxzh4fkwnMgO1McypelTkr2KBE5KALyEXcFQ/XBfqiSgJvIoser
	4TqzDOW/nXoJKe1KikaCD0fENTAqu3j06ksygmTb7RGD8d6TruWqdirH2CN8IwNrNpE3EYEiWPJ
	TALADhdosqviRhLExSn2+LOg/YthakPII/4eMnnDsSKEG7/IcTsUrb35YtgHxMM0=
X-Gm-Gg: ATEYQzwR+Nb+U9ExGbp2WPtNc5vBFWdFkGYtvdslTCgAayBh2OSTOmuxeQdz2hkoT8R
	TQzgk8KnIakECFOyikt65X4vS4Ya0OyrTF42sm9jEvgYBGkoVByyJwA99xYOyZ6CdOo7ONpl7Xt
	aZ61qw9PbbtFv8AH6Q0F4dmMTCQwiyDZd7wJFZl4TVt92Qm3O8LQmxo20S10u6/FzqYs31N3sSE
	9sWQgO91h14YVi1+NEycyizHrSMktwkTh572JHX0Rgh+PtrjUFP0qYBFXqEUaPoc/x/TJUhhURj
	pNNVnsVYlYevquJUxX+3Tc4o4S6vykUzc6v57bYMl2y/k2tskleQHPmNFzBLfDQVj9xDjbW8W8W
	IbYtTwR12Mj7Wr5suCN4uqoSGBjqTLhjbacTEfFE8CMR+QefWCekQ
X-Received: by 2002:a05:6102:6b01:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-602aed07a8amr5468732137.25.1774279083637;
        Mon, 23 Mar 2026 08:18:03 -0700 (PDT)
X-Received: by 2002:a05:6102:6b01:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-602aed07a8amr5468725137.25.1774279083158;
        Mon, 23 Mar 2026 08:18:03 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:f9a0:d7e2:7eb6:79b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm35936993f8f.12.2026.03.23.08.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:18:01 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:17:18 +0100
Subject: [PATCH v14 12/12] crypto: qce - Communicate the base physical
 address to the dmaengine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-qcom-qce-cmd-descr-v14-12-f323af411274@oss.qualcomm.com>
References: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
In-Reply-To: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
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
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zaDjliGI9P8SDSmb8oK5ZUowNY4iBaNue5t3+i0OgLI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpwVmEIhNA+qGksy0E2v+Dt0LShbj1QNg2y86R/
 vOoNZth0qmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacFZhAAKCRAFnS7L/zaE
 w7xkD/4xdbKrTGB7J4C8rkvde0/WRQFmeaByk8e35IH820cDb1zFim4oxGxug62Gt2ElgCJN5kS
 xZsQ7ey3+VFbU4w0uFyovx3bxhax55cV+yr03pDTh/fDokqAO6KyXyi3Vf/L7Oe5fQdAWFgJPrj
 FD+IJyvZzax/03Jj7CirAcBwAOfYwGQ7ra8b3A850SWX48wah2ncH3S/Gz7e5F9bpWqZjmRY6ww
 Zp7PfY2+oQwGMnq8rv+0m+E6vi5iTj9817XI1T4IQpQYE/iUkzITIhmVljlZyHPphm1pEWwZNmQ
 lMf4In+3V93D+/vu0TR4JKX+KMF4/5wjzMYybAGOY3I5klpEUhCBpIJHXIe2RIrpqpGAZJY4vul
 8uloju7us6uY225sKDTpnQQ1DpapFkm/Ir5clmslKrvnt/b20h6oYP8c9uh8yBVmLFTIlgEahoj
 73yRozw3wSjjF9frUEmQ+DFMviySFyLX60GLmhOPkQ9CximM3mRm3sK9+9kmFdL9pBhFXyFxT3d
 roMQoIzCZSKLSfuC9UkgNOK/ryTAOB647Lx0+DxpobTUmKNcp2YoiuE7mSwNxFQbxU9m5IBBC/c
 SWYx5SAwoU/9cD3mTbVbeI/fK5RF0oCDwVq1tVTgDI9yQqMSmDoLC3Kg5HCAHVCgQhhK6C0z2Fd
 wEAVl10ejvTe/+A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX0gFI+N0LmX7Z
 61ddlQGbC5ExGO2Ovf468212Op58Cl1PjaJzZV4SgvznWT6qTBQ3seW5qcSiRP+UFB0RHONgSgN
 RLbVm+zMxZpxMCBlOQg9oWTbpWnBvJepRA2eCqMTEeiDYIGOCDY+0oKqg36AwsZ4BT76RNcoBxp
 V7xUeyxgFtb4P4Mf19CklGDv8GBUXPWS0UuVIsboSd35xuXm6XIFgt+6l+gJSEnagkWux60YwUe
 sKlfvsAlNAg/QqB7wlYrVr7rgWx0sk7KFaGdnZi/33aft8cDrgR1pdxGc58eXs5OlT6cFWMKsIu
 EkvydPXSe4HP1ewq0VZy5y2fJN06uhIzknk8RTLS0drgpZjFbg91tqRn1I85YKJ8pIg/6OglhrO
 7coHP7n969Gh4cj8Do8dW+xRrTncGep1Fy3veBf27tuvplL5qLGKUXDIH9eddN3HsprMwhR14nF
 6d5xewDrGH73vLQF6hw==
X-Authority-Analysis: v=2.4 cv=cf3fb3DM c=1 sm=1 tr=0 ts=69c159ac cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=6g4OycmRf1yXlxMorl0A:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: -Wrib8CGnM5cPQQI3ZpFUSA9q5FxpxLp
X-Proofpoint-GUID: -Wrib8CGnM5cPQQI3ZpFUSA9q5FxpxLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9610-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3FEBA2F73F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to communicate to the BAM DMA engine which address should be
used as a scratchpad for dummy writes related to BAM pipe locking,
fill out and attach the provided metadata struct to the descriptor as
well as mark the RX channel as such using the slave config struct.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 5c42fc7ddf01e11a6562d272ba7c90c906e0e312..635208947668667765e6accf9ef02100746c0f9a 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -11,6 +11,7 @@
 
 #include "core.h"
 #include "dma.h"
+#include "regs-v5.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 #define QCE_BAM_CMD_SGL_SIZE		128
@@ -43,6 +44,7 @@ void qce_clear_bam_transaction(struct qce_device *qce)
 
 int qce_submit_cmd_desc(struct qce_device *qce)
 {
+	struct bam_desc_metadata meta = { .scratchpad_addr = qce->base_phys + REG_VERSION };
 	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
 	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
 	struct dma_async_tx_descriptor *dma_desc;
@@ -64,6 +66,12 @@ int qce_submit_cmd_desc(struct qce_device *qce)
 		return -ENOMEM;
 	}
 
+	ret = dmaengine_desc_attach_metadata(dma_desc, &meta, 0);
+	if (ret) {
+		dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEVICE);
+		return ret;
+	}
+
 	qce_desc->dma_desc = dma_desc;
 	cookie = dmaengine_submit(qce_desc->dma_desc);
 
@@ -107,7 +115,9 @@ void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val)
 int devm_qce_dma_request(struct qce_device *qce)
 {
 	struct qce_dma_data *dma = &qce->dma;
+	struct dma_slave_config cfg = { };
 	struct device *dev = qce->dev;
+	int ret;
 
 	dma->txchan = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->txchan))
@@ -119,6 +129,11 @@ int devm_qce_dma_request(struct qce_device *qce)
 		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
 				     "Failed to get RX DMA channel\n");
 
+	cfg.direction = DMA_MEM_TO_DEV;
+	ret = dmaengine_slave_config(dma->rxchan, &cfg);
+	if (ret)
+		return ret;
+
 	dma->result_buf = devm_kmalloc(dev, QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ, GFP_KERNEL);
 	if (!dma->result_buf)
 		return -ENOMEM;

-- 
2.47.3


