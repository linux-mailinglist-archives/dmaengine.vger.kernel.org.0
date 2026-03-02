Return-Path: <dmaengine+bounces-9183-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFh5Op64pWmDFQAAu9opvQ
	(envelope-from <dmaengine+bounces-9183-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:19:42 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 662601DCA25
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0A44311CC51
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B4B425CE2;
	Mon,  2 Mar 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lLQlqDBd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HzGSeRe6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B3423A88
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467077; cv=none; b=U5I8LKRcPwbNBPeMpWRfKn64uq/2NSe5MLu9FT9t487fEBZEA0sx3rQR8yYhjGSRvxEMM17keDJN8ZiKS7+6SNjAcIpeSpUjl47/6aqJY9Rrm/Hw4X8jTCGSutSGU3UBwbEKaaLYJT6MkP8Gl/7Z+vSM8QilFkGrA4d+T7u5Nhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467077; c=relaxed/simple;
	bh=aUMoNrCGDXfli/Niiqe45turoruXO4WeijyijWZBwgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbqDD2lBFH6P0gAn+WpuE0RpoGi/9v5+CfyO8x2tsjlcCy4HR1SfpSlFcSioSjxvaVnfuAj3zu5jR7RuAeh2hjqFuZIJ6EqpFpia3QH/h08DHyGL51v1hWwwXyNX3uRPd8kl3Y0cnm7KSfzjC0PduXk3cCJMxhjECCBXJdS4w4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lLQlqDBd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HzGSeRe6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622B4MRb3561526
	for <dmaengine@vger.kernel.org>; Mon, 2 Mar 2026 15:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YTHMQ74pG40cf2TThEo/dQpxpxcnmIMpmWq++2akSHc=; b=lLQlqDBdv9RwvqME
	yBGs4nQ6md19yry3vx53hoMA4iTI9D8LDJOVvquidw7pWr3C2ACNmXVLaTfNATg5
	K4cb2Kep8d/g1SriXpAxFJdiCbo0mWaNY2/vtBX1GznM/B+0tg14MTiOVjSL1LJN
	pEfl8m0iJsNPcrwc59+ghfgorhlVSTz4WWokjTKdm1HkweluaexxwOjoBQw+2l+l
	b34TSYBe9e/9EedeqQd0H38q896cYJ3osgHbDBa6NhsmwFmQCZj3k5MZBAZ656ST
	cxTkGPK/fijtah67StX2Pi26fFUNUT/lVSRrVjl1q6jcd3wsE5CX8Sw2g5GLgsHt
	goyObA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn9bv8ydy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 15:57:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3d11b913so3479442085a.1
        for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 07:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772467073; x=1773071873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTHMQ74pG40cf2TThEo/dQpxpxcnmIMpmWq++2akSHc=;
        b=HzGSeRe65rAc3rY5DoBboEu6v+ZrxvFNAiJ27ZY3yPwTVcZfM1LGnxqMnw5H+q9I0K
         tulZdypi8o3eENMNA+A93liZJyqW5RgCAbqNhmdHqiWi3+Xxv5/VtllmjEaTHP/9YR5O
         LQjKu2pFiEpqr8lV9pxaTiuu3HXEzbByu58ynsyydf/gj7PS7oUoQGR6RlMsJI90b9yF
         n6JwIMtECkPOwrnrCVDeSvijSR5IS3u4DsWGlRLMvWagRathbljn9IQaUOt9eVpmZzAY
         DBiXZLei5ZMo29peaNklkZ+KlqTJghTzrHF3rF5DP1NPsVzO4sNuYajbihtegBI4a03M
         0zYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467073; x=1773071873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YTHMQ74pG40cf2TThEo/dQpxpxcnmIMpmWq++2akSHc=;
        b=KoKl0hAD4+9TyL9WARmy8Jp3Wb4g5S2tv8AHzWKPbT4wqPFBh6ilZZRc8Cu5kDkiOX
         h5DcckWbZpJ/sIlKtpBORsXR46ZnnXc8D/ZsXh1R3MSzPNb/xZ+gGDsHqrimaTuaNhny
         YPOTncvit+UtHUQBOiKRUkqPUVPqEw35JxbAGCY4mpUAcki0llRc+7X4SqOpkXDRUJI/
         ZGalZVXE2jB9nHAiqDGlL2odSXvHkszMFdNRBcL84t58roy056evaCBQFx81Q5ROatDg
         ralKqqGLmQyPcJoR7Pm7I4UKyTZb5azPVDHSUkxSpHyp86TwyKmvW4RHWQDgJJ95xJtJ
         /pBg==
X-Gm-Message-State: AOJu0YyKb9RGKsEoPEP55Ld016PlcIu6JldD/RfhJuKZ9EbQdP1vZUoE
	4CQkBREjnsd2LPyXWCSfjcvfynOBFtqcNAIVRYbc/FHXBeOaVmBm7ykBEcp1EwRk8k1WxKoRLDI
	ITu9/9jES1HvOc7OcO7hu/oGqZgT5QHuZrtqzAwQ+2nIJdzaGsbFsiNuPbnRQLxM=
X-Gm-Gg: ATEYQzzTtfhEvfNqe3T/QxpvlS9CfwuPIoQ//X/+5xTL5hQ9Prh5VtURbVR6QDzlW2d
	E3VKZiTCSAvjQBJivX6wT6on2S4hPs6xJejI/5NLOf/NxyZS+M2zMhY+44mRCQkY6uz9ya30lYn
	dXBf4NEWMQJejG2J9ESqKgEEpHM01xiFjlRU+isxTwsyp/Znof0rPuXK1XruZdMMU8zGB0XzF0B
	xTGh9byDBNLmYyQmNOa9rnrvdMH2Yu2iz3vvmeWq3TgfnzcFd/rx0YNDJJMrBclHpTRaDEKojrO
	vGiNabc+iE4qISreCRnA/uulDYR4LXBHJjlq+xWeE1Qx04wWtfZ5SvivPgYKmDFEkOSIQ2cmjZM
	rO4MTlJg5wW9txKQVJ41fUY3aQAQYDyoKdo0oS94fxIUmDQWYPPbB
X-Received: by 2002:a05:620a:2989:b0:8ca:ffe3:3d3b with SMTP id af79cd13be357-8cbc8d29be0mr1478734985a.0.1772467073174;
        Mon, 02 Mar 2026 07:57:53 -0800 (PST)
X-Received: by 2002:a05:620a:2989:b0:8ca:ffe3:3d3b with SMTP id af79cd13be357-8cbc8d29be0mr1478730185a.0.1772467072663;
        Mon, 02 Mar 2026 07:57:52 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:87af:7e67:1864:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b41831easm11282438f8f.12.2026.03.02.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:57:52 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 16:57:21 +0100
Subject: [PATCH RFC v11 08/12] dmaengine: constify struct
 dma_descriptor_metadata_ops
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-qcom-qce-cmd-descr-v11-8-4bf1f5db4802@oss.qualcomm.com>
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
In-Reply-To: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=aUMoNrCGDXfli/Niiqe45turoruXO4WeijyijWZBwgw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBppbNrTjy/ojBhX/ZFgmg4UwznZqz412Fh06ExU
 MrjXRXycaKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaWzawAKCRAFnS7L/zaE
 w0UaD/4kKdICehR+EWUpEJ7Xw3Pn+Zs4aSTYcrf87riNyI4MzlhCH9lalV+/4BgyrQyWXL9jTIY
 E6LoPKCUQ+NdQNJ2vGxj+QpJpzJ6UccaNpN6ZUZK0rvts+QJ8QaXx3X6RBZmGgZOHe0cwxhBUWl
 aNraBhcjruZNqcafqUeryEjGqOqg+6rsfB0md5jISCrvM1Y3HPo3HeFT4vWipDT1qGnWh1u3rJN
 lMvE4e4OSeXuVXrB1TRCawmTN+F4B/3fWGKhTlSIvZoMPztvk3zPaBlI9x7CXKara6Ar0G9nUq5
 egR+gTGfmAmxqNojshzYdq4A/ok0vrNoZInhe4AR885iaIaBZukm1rbb+Egd8oOklSzOi1HMGv5
 OH1ZH+ZBRpeJcK71LxHRL3gLkkiwa4KnaLE45jL+8z2bRwGPN+RHc4vgkcmErEOWZFmN8X1YSQz
 uWCzc5urAtYMJXBFGkovaLpeEELBflXDQeQOpVyAQwdU6C+D0ln4C2Lftlu+zDhSw2+UuBe+WxK
 Rj4TxlDts1Enx2YFfESAsXxdfCIlJm6f7FsF0TEJAWdkm98ziV65XXVDtbT37J+NWU6OQMbGoqv
 aG4PjmKvoMvJz2sNe35Bw+OcH/MrfkY1SS0ewx3s0n6kx79xujbAi+fo01EvBPTKRt2vGywy5kM
 PO6CirSIe6kREYQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: jxx-p1nzkuDYtg7M37obAj5HFb-kVBai
X-Authority-Analysis: v=2.4 cv=S83UAYsP c=1 sm=1 tr=0 ts=69a5b381 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=XeVHrwws4l7kqE2Ex6IA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: jxx-p1nzkuDYtg7M37obAj5HFb-kVBai
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMyBTYWx0ZWRfX/XyPImnkPly9
 ohPbOwPeciKyGURCwGJcxT2Gfqwu2e4cuaeY6as9Jdo/4qkAHIBdtIgu9G6dffy8HUnbwbzC6Fh
 Jc0I8W2Wsb/rpzWDZBhVIha9wIEVTrYc+czNgqhTIWXmIa83e6V1lALWTgBIeXG4LkM8rL96xLK
 UIUKf802g1CQbu6mQTqs5yrj3caCRKoEW+flQkTAAG3wCWKpBnJ3O5Hl7p24bTFhRDqVD5z7XTt
 pRg05a5stHYID5KXr1NfO9jznIXyh4kqDVcV+3oPpJDFe7TIa6byH32U4Kh5lj3d18n0H01k2F7
 57gUdKMKBt3nuqUt4qqKLNcIPH7p7ehUcT+AxYF5Vw9SnyTooGZX+TBXDSNYSrq+1cc3X5mcdVs
 1FXtjkffHKDGxuDTpsX+d25TCuBmqr9AbqMc9JIMZnBIntgnMzRDAxjz7b0wavg3YHdYSm1ovMH
 Rka47/B/6Ioe1QMprFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020133
X-Rspamd-Queue-Id: 662601DCA25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9183-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

There's no reason for the instances of this struct to be modifiable.
Constify the pointer in struct dma_async_tx_descriptor and all drivers
currently using it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/ti/k3-udma.c        | 2 +-
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 include/linux/dmaengine.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c964ebfcf3b68d86e4bbc9b62bad2212f0ce3ee9..8a2f235b669aaf084a6f7b3e6b23d06b04768608 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3408,7 +3408,7 @@ static int udma_set_metadata_len(struct dma_async_tx_descriptor *desc,
 	return 0;
 }
 
-static struct dma_descriptor_metadata_ops metadata_ops = {
+static const struct dma_descriptor_metadata_ops metadata_ops = {
 	.attach = udma_attach_metadata,
 	.get_ptr = udma_get_metadata_ptr,
 	.set_len = udma_set_metadata_len,
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index b53292e02448fe528f1ae9ba33b4bcf408f89fd6..97b934ca54101ea699e3ab28d419bed1b45dee4a 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -653,7 +653,7 @@ static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
 	return seg->hw.app;
 }
 
-static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
+static const struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
 	.get_ptr = xilinx_dma_get_metadata_ptr,
 };
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea9844ca6161208362ef18ef111d96..92566c4c100e98f48750de21249ae3b5de06c763 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -623,7 +623,7 @@ struct dma_async_tx_descriptor {
 	void *callback_param;
 	struct dmaengine_unmap_data *unmap;
 	enum dma_desc_metadata_mode desc_metadata_mode;
-	struct dma_descriptor_metadata_ops *metadata_ops;
+	const struct dma_descriptor_metadata_ops *metadata_ops;
 #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	struct dma_async_tx_descriptor *next;
 	struct dma_async_tx_descriptor *parent;

-- 
2.47.3


