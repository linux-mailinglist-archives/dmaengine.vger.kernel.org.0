Return-Path: <dmaengine+bounces-10740-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIDWBydhEGphWwYAu9opvQ
	(envelope-from <dmaengine+bounces-10740-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 15:59:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ACC5B5B11
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 15:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 042C830AE51F
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC6466B69;
	Fri, 22 May 2026 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VtBaVqoZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EzNCRUr3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F944E053
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457246; cv=none; b=N3sGo/0xX6ZwCMQuMWxjdFKSGoGDcDIrKpgk/DMr1dw/xFJ5n2L5g2Wx/ufuB2QkX3aZYIt8enAXnZrjb6moFdDv5rOXGjH8Je5lg1KUQLYA0oLgKCcyyUovzye0YsCKT/+AjgkEXpUwHu0+O+dcKk+pfHS6q9rIIOL4TnlN0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457246; c=relaxed/simple;
	bh=1hqWDd/0bXE3LgLE1RPTV9B4kaYMiY3xCYD1OrMkUU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgP0qErYPT1VxmUKjdzajzB1N7nbELpM5GtBrz/w8RwQwSO+AcIdz+aJWqkY5eduBv0jOTEVPNxdUlrO9Ofv+xCjGMGGbORaU8rFg44dLw+sDzrDQKfHDv4AjbsXWbwWsfYv+1BLqSaj5whJ5+/FnY0qhAMuD7da9gk48zSAI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VtBaVqoZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EzNCRUr3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8agMC399180
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m4JgpUHbn9N6lGMSwan1LLLr3sxikf8Sswa1p6VG+q4=; b=VtBaVqoZwk5lMZV3
	UD3TtCxT47gJEz2u728obOtbgeK7KHN3RLDsFeKa+o5HZKcDojGAprLzAbWXJti6
	drsSgC81+qtkdh5kG/APkyrWY694X81vQ4EdRVx0Gc3Pwj7P6jM0E+R1fzH+WyB8
	i7eDkQ8UYdeRhfr8S4nVuELqHHyQ0EaLdjgVoJgBpoFrdJ7mAGoeaCcwif+eXydn
	k8C5/tSLDoVjWesd5VW2jpfvnU/TghkFT7j0eEVDNwVxaMX76z1GNVrpm/d5AprR
	v0bfTzRcOoWaef7ZaXD/LTmk8Cla7T0QCcYSQ9vW76gczWsQcaRFrelWzAmBNiWK
	+ivbzA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea5p9vgxm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516da5a1db4so13181641cf.0
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779457240; x=1780062040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4JgpUHbn9N6lGMSwan1LLLr3sxikf8Sswa1p6VG+q4=;
        b=EzNCRUr3voNaCvf69x+K9Yn0DvWKQkolFHojx/xpQ4eRgk/KXFCPAgzWfOpgN9oYVq
         Mx7CO5fNW3qgEt1MtIzzo5yX3lXbjH5lZ/KSPTbyfjawBCXVMs/L36atRLbxm8EkBSlk
         IOvtn9pV/EIRfl87LcKnSwpfrI1d0P1GddU5I7Oon4PRHFJ950EoshfSBxbbuzk3aufV
         Ifn99oXv9Uatwxcp5SiV2RBbY+YyaRVt8VqcfKVge+i9vq7fbqc4nJ6VuhWnpqNyDIzC
         d3zWNJRqiFFikncLjwWKNQMuXGBg4xNyoNKkjvUkKi66fGReYPGrdY01cL9rs8y30Osh
         yX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457240; x=1780062040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m4JgpUHbn9N6lGMSwan1LLLr3sxikf8Sswa1p6VG+q4=;
        b=ROcWCuKM+gHJzPl1AzFp2HsTa0n4qu6vX34zlnWZsDDAywqdxvsZaHIaRWzy/lLbmb
         WoEKZ3clM2S5ieoviR8QMKVbEAZJ8f+VpDfnmdStPEdtE919H3p8YrLhIvuUqXxJOLpC
         qUjPQUK+HWUdK3lEbQfUBNm7knhAWmU1qJPqBJkh+HG2UOF5/FCoIeLTx/jqodN0p9jL
         2oj21NvNb42ovLalTPVOwQ5Ms5Q0wo6pI2MftryytNSWntDFHdSJpsF/al28VMYU/jSY
         dfyNsekzzJ+PbCIbJRG3Ld7Gri7ifeksItYqZuR3C6Tr5mgBIeqqaqLuzYGtPc++NfF4
         vkwA==
X-Gm-Message-State: AOJu0YxZYRIPZFYvW1VgV69VUe3nByN4gsOy8dtucNCAC1xW8/gsJNAq
	nQGmsmt9oIR7I6/PvT5bzvTC5rucTQRqSyc+Kfr53JZb0MPj5DHGd+7kGaL0rY2GMKQ10Ovarge
	YqIIOQpFFr3ow4xs2a8MDCfREw95USB3hE4y1JT7MPEyeISN6bUq+qCjKRPDfcmo=
X-Gm-Gg: Acq92OGobkveYzIci6Q25yV+nhpRtoXlUCBsGZ/AWNNax84r885icySHFblGFCPMpdY
	hezy0iV/LH3uqQs+zweOI0aP1lJx1YSTRSmwha+YLgdLyvFMv9jVIcGq6zi4J7ht3SrKHTIpjU4
	+Q6Ugb1Yx5vQ2I1f9J1nUtyFqfyHK1D9RM+2/Ni0l7xdxPdTNcDms8n/ruh0ZoBogoMuQ/o/aOL
	UbxyLPJxWxwWUNhrSMuIjrxNUeC3bjFRVqcwPu50o6s0IA35e0NLX9fCbDvP9pnkAPwAwG5Gt3I
	KznrdVMAcrHzkEriHka/09O+W4HOJfhCAY1NfImNdE4rPWs7JfkuwH3AGRgjCSKTSRR4+U3nkls
	lx9FcrkxDtCn10o13EFsoOq+me3VQr3aBzU8nD5BUqCd9U/IwvA==
X-Received: by 2002:ac8:7d49:0:b0:50f:af1b:1dec with SMTP id d75a77b69052e-516d43a1a08mr50136751cf.40.1779457239952;
        Fri, 22 May 2026 06:40:39 -0700 (PDT)
X-Received: by 2002:ac8:7d49:0:b0:50f:af1b:1dec with SMTP id d75a77b69052e-516d43a1a08mr50136121cf.40.1779457239371;
        Fri, 22 May 2026 06:40:39 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:2fa:6280:a48f:fb37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c600esm44912825e9.3.2026.05.22.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:40:38 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:40:03 +0200
Subject: [PATCH v18 10/14] crypto: qce - Simplify arguments of
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-qcom-qce-cmd-descr-v18-10-99103926bafc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/ngcILYEJOF3Hp9tIAViTgKfkzbk8A+3CFbfctgioS4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqEFy7XqE0J6HFR5/qidJsYGFAAf4n9alpoXZOM
 /lz7y48oA2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahBcuwAKCRAFnS7L/zaE
 w+4AD/41ATu3vdLYLOhWDKx46u6g9Yg6MCPYiPYG+5qEz3ulKJmxsA3Gd7QVw6ZvZeJ5ZLaWV3V
 ZKZ1WY3LvfiuMJumw6WsMoVc3kqnt5ATafmLA5wnTt6A00y2jBg16umeMUxguFiJQHqllJ+fWFf
 XWfuJdrlxaS0nPntfzsxG1b40Q4eBFZAPIImiZ9cR1lQeXoK1bPKG9DjctMoU06WGQhgBPlbZ1t
 UBPNsbXjGK/jKt5et3IGgMNRZ7uDh21ETHojZPOAo8t98NwQic5WJ752AHb1PUd2DaVHhpY3IM1
 w+S7PN46GShJdKYT27ZP5mnU6QwDPOmNpiuiLqajrg92vZwz7pfLb40o8TdX/thaD2jhvne+DKg
 YHmrOfMJrS3zfeAhWPp7YdhZTVpD/tLpRd9+2vCyJWjflCnC/2C4rqOsHSe90PWTaLK73TdLHJh
 e48eo8X4MFDQsOqFcSi5+XTTKl2y0l/J164nf6R4/gN9MeJVytsdOP0FAU8hW5X5gtjuWyFt670
 tywRYbs8Lz3sDIg1Jc3QsawDhxOhuAIe0lL8VXn6kiEJLPxdu5Qn6GmNBrY41r/JsqFyhZQ/QV1
 QauHuWPcK33VaowA+wRtlRa1QY8Q4KUzMOP8qRUiIzA37P3i0nfg4xoXzhaMUCKqVs8jhXj6SOi
 4wyHqSHHNPKmkkw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=DKm/JSNb c=1 sm=1 tr=0 ts=6a105cd8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lH6k5GM5CfRwGFUYfCYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: VYXxLUuiQrngaAfeyCC81eAxVQmheOhl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzNiBTYWx0ZWRfX+24/9CYOwM2p
 AWJ+kvLP1mZavJDvtSx5q6MWeBaHsbl4OpTl7hSGG8qk20EgX2RvOqQfPVvZdS6e4cJsb8DlTg0
 7NJNyxzeOIxijgP+ywD8YOUXpf+tq8bYQfAAph/y/7tnLqy1NXsIYaeSN4FH3hITS+Dm7LR/er/
 atesNQsObbkm+KSqAk4U3XcfnLgVXBG9nB5+nBztO+/lJF/zENXV5fyDu1nvgCWWCty0JYy0gW3
 2xNQ1z3WE+ZKv5cWJI9rq3xeUmhQSLKjrmubrt6+wKMNmywGuMxzvSwoCjL1B1sTY1H/Oh6JrPE
 Dh1DY9fTpIoEpwiM+3okV6cQIZCSGaiZWQvAC8CeycVT+AwOpC4J6eAPkBE/XTGEBELlSI1oIgg
 H33ebaQbfwmBhCDCx+68Enz381YDIZi7JGdICtI4H9J+pniI9HDkldUHvw7EDUXgiVpspG0tZXr
 NRXHeYheSv+g+IhFPgQ==
X-Proofpoint-ORIG-GUID: VYXxLUuiQrngaAfeyCC81eAxVQmheOhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220136
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
	TAGGED_FROM(0.00)[bounces-10740-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: B6ACC5B5B11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This function can extract all the information it needs from struct
qce_device alone so simplify its arguments. This is done in preparation
for adding support for register I/O over DMA which will require
accessing even more fields from struct qce_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 2 +-
 drivers/crypto/qce/dma.c  | 5 ++++-
 drivers/crypto/qce/dma.h  | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index ad37c2b8ae53a373bb248aff06c3b7946e8439a8..a0e2eadc3afd5f83e46724c8bc3e3690146b86ba 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -238,7 +238,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
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


