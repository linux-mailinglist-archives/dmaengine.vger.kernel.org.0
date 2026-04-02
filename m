Return-Path: <dmaengine+bounces-9865-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Oi5D0aFzmnfoAYAu9opvQ
	(envelope-from <dmaengine+bounces-9865-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:03:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A9738AF5E
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 182BD31165D7
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432093F23B9;
	Thu,  2 Apr 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h56kFTWM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N5wjq56E"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0953EF0C5
	for <dmaengine@vger.kernel.org>; Thu,  2 Apr 2026 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141774; cv=none; b=NebtCFwlEZdkS4rSj0967ViIObx/thHcVHsUOTr6+zBrpSiubbZAk5bvW/6yip87ksybG3AvzdRuW3DXfQqFMEsAxCAstsGEWv7kEzHPZDUkNTjr2feyXyeugyrrMV9ZbX0x9drOWm0R1584HqIP6AaQXgLusQf3hiUOmiH9oMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141774; c=relaxed/simple;
	bh=FnVBtOe0OnnBy34d5WsqwWSUvkeiYQ93/vJc1qwp/2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNpXnRq13Bkg/LbHLWNdhxwM6wgianmgtQdp6YTH2W2WKaC4/fhg01eihIR2ZaOKakP+hCF3PR6RlXyO9QTvDoRuOZZIyTL+G7n837KIHEi9oMbi5Mt6UxoHQLP5dlUoG9AZhpK8hvpDpkfOVTRURf7SoCnf9vAPsn9G+MQod70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h56kFTWM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N5wjq56E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632D30BQ2798832
	for <dmaengine@vger.kernel.org>; Thu, 2 Apr 2026 14:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MnBQFcKPOgFHzTGJJB4DToRykxT+JvIdZWyKHEJZL1c=; b=h56kFTWMUlgm4OaU
	6rXGKYNDIfODFF7EZWmThTDcoVcb3kHRX8osbRqePsIdk/90JI+SQn/34ZgADqYz
	2aJcqsq79ghpcUcn6n/84o7z88GxLdiG/ULJi1XHp3O6/jvP1cUAgm9Ya5Z3qI+J
	+2Ukge4IYQPNCtBN/ZQgwBxQmY7XKllup37qKoxZDtCVIGAlPNZgGbfh1xSeeDzC
	82GaG3k4OdM4oYqjwHraTqfBY/PKVVRgAWJTotYv8EpGlpdcTXGtBZIn6k1oI5Ki
	pumzqD+6DNqsTkRxtFXWoe1LKbX6DPzF4tjdn4T2jHrWvWENyow9NyQdjvn6jvqF
	L1lw0w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d96hk4ptu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 14:56:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50917996cfaso29863071cf.0
        for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775141771; x=1775746571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnBQFcKPOgFHzTGJJB4DToRykxT+JvIdZWyKHEJZL1c=;
        b=N5wjq56EgKSq4NtaDxTcbKXCN+hXhiSCk05FL7iNdTrAeiZuCkSlX3HUaQPskXRpVe
         tK+2KoJjZA1tnoXmFlP+2H7z8p3sgpDiXpGiG1FrAwNEi2TFALRCVgH0iRP8zhgtZVYv
         VnDusuLAMtY2Nz6pfo7KMI2oQtwHYGMJ9gQ4DHBtD2LqoBnWn/+omIRLJyNdJiu7/+dS
         q8WlddwpbvaB/mMPJgzRn3YdjGd2pE7Bea3mrZ2TdtpyX9koEmaxxprG/r5CMKy7qKkt
         eL/lBUZAceaLRm62hN5DPzITaKphUcTKd6nT2haXixrjmPiei2oZVgwJAJmYZFEczcga
         9ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141771; x=1775746571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MnBQFcKPOgFHzTGJJB4DToRykxT+JvIdZWyKHEJZL1c=;
        b=C7hhNw6dQmo4uvGPUgsQpEBEXfbMj0xIQZ/wX5gMttoMp4CRdE69n176eszBda3woV
         LAurheyPHY/W1jQ8/6rUcE88Q7i/Hn+U0m2Pmkv7Lf86UHf5xFgJGXVZUxJTkJvcCBLC
         XUZWXXHDWyTJCO5taVt+8L5JNJIQu4u+CbGa9CtDyP6XFDHBRJMnUGh2fBE+XVGk3iWN
         PbtK9cWTBQ79gM0U90JmWcXE5Qp6S3JUbfH0qyFPMDZ5cLfki5WONOU+6PiXkQY3xGzx
         XP5ax+f4huPHasJ7l0guOzJXx9wPU/aVJygwI4TVpayBNBo0l1JpbUEhBBKmx8246gbl
         BTaw==
X-Gm-Message-State: AOJu0Yz3uRSAD51cHSnpGhwTTjvxFlUSfu0BBXA1iLWYbmDkfYG8kFne
	LlagOgUfC1H5R1m6zXFqtDu30vQTjH+gq3wsRaWDXyTlQD6QmVHdDVRv43359WKLyDCzUOjUk63
	/6Kqrw5T+HEWd/8yV3hgSM89+3L8TUtwHS72OknXKGFMy9rAjPFyrxe0B1sNa0XI=
X-Gm-Gg: ATEYQzxsXJKKLSvrVIXg7kexGL0urqQq3WmgkjOOyTaiMdgodiHJcGLT91wCSHKmhvD
	jdH8VMVA0uGYCviaXF4gHjBa+dFOJRAuDP7Kzo6jET5cYFof+q64OTSvoDSY7M4mpHfyqE5hjoY
	mWKOkstzLpNYSBkZpwSCuYNA/QZHFisbxbJBlbu8wFP4TP7JRIVmzQS/6TvetFj8brQcF6Z2VWt
	m4LUzObJh/U0qNY+x7KC00q2FfBjINMAkhh1JeziZefXukQBWMHHffiI4TiFz3KZrvXLRgSPvuk
	K3689wRIgmDMkpSsi9WQoF0qUHc275AIRroKeSacrGXyNoeK+9M0nsAzDKFeONu+Pr1I0Jyl9xN
	3WDw81ouKlDW9ghZRE+PQDhFSkYO6gGSaLSyVVY0cvnzjYg5w0jy+
X-Received: by 2002:a05:622a:1f17:b0:50b:55e5:ae16 with SMTP id d75a77b69052e-50d4bb2f15amr60483781cf.39.1775141770809;
        Thu, 02 Apr 2026 07:56:10 -0700 (PDT)
X-Received: by 2002:a05:622a:1f17:b0:50b:55e5:ae16 with SMTP id d75a77b69052e-50d4bb2f15amr60483211cf.39.1775141770327;
        Thu, 02 Apr 2026 07:56:10 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm7234038f8f.35.2026.04.02.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:56:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 16:55:21 +0200
Subject: [PATCH v15 10/12] crypto: qce - Map crypto memory for DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-qcom-qce-cmd-descr-v15-10-98b5361f7ed7@oss.qualcomm.com>
References: <20260402-qcom-qce-cmd-descr-v15-0-98b5361f7ed7@oss.qualcomm.com>
In-Reply-To: <20260402-qcom-qce-cmd-descr-v15-0-98b5361f7ed7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3159;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gRGqUxioVpJcY9zBfeIZn1vIilzfanwkfyseaIOaQFk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpzoN0Jnvqzol//1aftLcHIaS6ZlwSZvrnLYFlU
 mZBU34nMRqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac6DdAAKCRAFnS7L/zaE
 w539D/9iuXTON0oYTfiow82EhJT647lh+WwVedrhINel04kbhUedgYSrGKONqAPKhsF2rniV2ez
 UYvaRuki8fe0nkKr/yRK/Cd38UxQ9eXck6xk12ZFC/lTER8tQugESXXQd+8ZpugdvNga37jGJBh
 kCOCYtWrdI1upUP3N6qPwXpuvmyKAlnfjm85BrPu/lQHAlpJpxt8sEToCLba/cbVF/NyflfsdoM
 5+Y5vn81JjOXz6yRq121TVSQWlgiD2bAvjfiroHBKLLpg7eGVux95IccKfUwh88hiOhpF3EiXkZ
 D2E4VTyOkK2VZQ3KmBq7yJ9FxOs6bkfWugYHMLictueHXev1vU5Gf/MRnGQYvljKlz4ADnRSgO9
 M8wUecv7z4KGNEBMPryMuQDgSVRVo6n+yD+GMD2IRH1pL0tdNDEh0V/DBYeU6DF++dGhnWwcay2
 LHbfESxUk6kyO/h/CvZf08SSGFd/ihuDY8sBx5zPoqpXdd4Sy95Mmt54lk3abkj/95v34RRd7nH
 rKbLn4AVfHply6+hMV9EEzeuPFN4czJCMJ0dxSQRmG/DkfS21YKDmQ4krQIQc5yz24yD9r/TZux
 D0YZQ3RIjUZYHpgkxkhA9VUyQizSn0HPaVcohkqykPgJaRUHO5FckzqgKMebNAmzZWyvekO5HLV
 58DJjEhSe+gPLEw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzNCBTYWx0ZWRfX+oIqtwHO3zvY
 EaZFqdYQd8aTcm2lnFX8jq+rQcNELCBquz3tOqHdtYrh3MLFTcvLRmFS8IEun9a7DVMgNnB+U/U
 81YgFIxw1qrldUK6hvGoLcqrOgwlr7OOMBEIch100R6DUTfOeedpX5ISViFd1qYtkcyw/mqBict
 AN1EQcnFcKKEEPiPzB8ymTA1dJVSaM8nJWe5X+LV6z455XtMa4ljX6WWs73pHraAD+Ab2TQ/cqG
 rgW/n8YtqW3q2OcOcJucBEGRiU886mSMQAPCJW+0gY2PF1lgpHWEiyUQX+IriqxhU6raW30Xj1J
 6qyDEMiZZ1mfTmSGVDKQYlzT5wwdjW/nIIugFxzsnMrCO0ZV3sV5lm/4RxeXEeY78yMZc+XZ7To
 AwJx0BinRucYae5Q3ZPeDPMsY6QHRuflxLw3fWihB796GNZWN+eqZGXU/hdl2ecmgWU3+bnd+V3
 Yo1lXECzYYRjZban+ng==
X-Proofpoint-GUID: HIiEI0dKKg0fKu7qrLWG0gAFVGxv3I3g
X-Proofpoint-ORIG-GUID: HIiEI0dKKg0fKu7qrLWG0gAFVGxv3I3g
X-Authority-Analysis: v=2.4 cv=e9ULiKp/ c=1 sm=1 tr=0 ts=69ce838b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=76fuQ0JqpD8MvifAs1cA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020134
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9865-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B2A9738AF5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the first step in converting the driver to using DMA for register
I/O, let's map the crypto memory range.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 25 +++++++++++++++++++++++--
 drivers/crypto/qce/core.h |  6 ++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 8b7bcd0c420c45caf8b29e5455e0f384fd5c5616..2667fcd67fee826a44080da8f88a3e2abbb9b2cf 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -185,10 +185,19 @@ static int qce_check_version(struct qce_device *qce)
 	return 0;
 }
 
+static void qce_crypto_unmap_dma(void *data)
+{
+	struct qce_device *qce = data;
+
+	dma_unmap_resource(qce->dev, qce->base_dma, qce->dma_size,
+			   DMA_BIDIRECTIONAL, 0);
+}
+
 static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qce_device *qce;
+	struct resource *res;
 	int ret;
 
 	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
@@ -198,7 +207,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dev = dev;
 	platform_set_drvdata(pdev, qce);
 
-	qce->base = devm_platform_ioremap_resource(pdev, 0);
+	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
@@ -244,7 +253,19 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
-	return devm_qce_register_algs(qce);
+	ret = devm_qce_register_algs(qce);
+	if (ret)
+		return ret;
+
+	qce->dma_size = resource_size(res);
+	qce->base_dma = dma_map_resource(dev, res->start, qce->dma_size,
+					 DMA_BIDIRECTIONAL, 0);
+	qce->base_phys = res->start;
+	ret = dma_mapping_error(dev, qce->base_dma);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(qce->dev, qce_crypto_unmap_dma, qce);
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index f092ce2d3b04a936a37805c20ac5ba78d8fdd2df..a80e12eac6c87e5321cce16c56a4bf5003474ef0 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -27,6 +27,9 @@
  * @dma: pointer to dma data
  * @burst_size: the crypto burst size
  * @pipe_pair_id: which pipe pair id the device using
+ * @base_dma: base DMA address
+ * @base_phys: base physical address
+ * @dma_size: size of memory mapped for DMA
  * @async_req_enqueue: invoked by every algorithm to enqueue a request
  * @async_req_done: invoked by every algorithm to finish its request
  */
@@ -43,6 +46,9 @@ struct qce_device {
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
+	dma_addr_t base_dma;
+	phys_addr_t base_phys;
+	size_t dma_size;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);

-- 
2.47.3


