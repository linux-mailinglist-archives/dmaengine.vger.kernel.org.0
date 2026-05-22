Return-Path: <dmaengine+bounces-10742-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHjWLAxkEGrvWwYAu9opvQ
	(envelope-from <dmaengine+bounces-10742-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:11:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA805B5EA6
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF9A30CC60F
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30CE400E19;
	Fri, 22 May 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0bLFzQ8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQV2Mxng"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E946AEC6
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457253; cv=none; b=VUHHxfa2/dkEWfHE3DIsl0fLrg0w48J+1YIarZRlnxAH7A3o/M/ur88vTIcU8q4n1qJcJdcfylRVTGr3aM/IqtG6aMWsPhb6JrefKy11SfD+5w2r6qluKXHTy7+HZiiEI+kMvg9A+woKRhPUoFeSuxm02cfNWnm9QRaHMldybzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457253; c=relaxed/simple;
	bh=haVTCoWg8OL+rLPtFm5RXGk1TNPHvQOhQxIunu3z1Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKltwb9dHlBLPzqHy3FfPkzw5bJKKpf62iWcddeflEYIer/r1Isz/Xiy1+K+kOcRyIn48OyuhhdJ+Gen2PWRq6ShzCekz2I6s6dL7GtDa4IuYafaH+em88yKdrMRgMVW1GK3EUXANOexNwPT8ZkHlZQgh6+DJ8OEXKdYDnC27gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0bLFzQ8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KQV2Mxng; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M90dmd2765491
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FYq1r0spQWHIRnEkazipWdL66tm0s91r38cl3E1vzGg=; b=L0bLFzQ8eB8qbZY7
	r0FH9KylIh7vCVAzy2P+aRxMGDMF71H2/mgtOVU5GuDJW9ZhHIJci89kGsxQNIGg
	+mCmqghMEoSbOJOK4KwlfqTR54KOdf68H5DayiImhl6nXq/PiywcFTs8ZF4WsElr
	9FLzJWMqMeS1YYY0Kz5myN72PaUQWnhCZLSnLa8lSuFmnVDDTaHo8O3fOTSqd1mF
	IbK7KJSIt/oDIdkcPZ0HAtBdY0z68cZ51AWK4QHQttZ4kBzbA9k4IGw6gAhW/DTY
	b6nOQD5xYE7s5/1vFskf3/uNjKJczu72MRW1vCRmr/Jp7GZOdTWyVi++InfMnIsp
	+B52SQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea3u7w66r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516ceea1984so35121031cf.1
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779457244; x=1780062044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYq1r0spQWHIRnEkazipWdL66tm0s91r38cl3E1vzGg=;
        b=KQV2MxngREueqNIxlnyXvaL25f6FNMyA/T8fljxs6ZXPRxlpLMCNnw3pTS9ZksXWKM
         +qPgVoUw5kF4sz0pmMFeot2+lhViJgsHtlgVePAP7d1DPoz0rZ3SMx8a6c8k0eFyy4t+
         MSD+lYzVPCg+s2DLpt66+x04dgxHYZ1dNa0UUVf8oP9HRJV+OJ7MVMcsdMz9s4rnRXzq
         NREQ85IjzwWgsw8W05v5W8MrOO9snNa4L/v92YuQR17gYedZ0Fhvcyll+6Ry53bxIVCT
         K53vtQSXQD7y/DiOkyGO3MLxLLqxu27JtnSATkrEI2ZycjA2gTz85gY+XEemn4GDYbkD
         72yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457244; x=1780062044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYq1r0spQWHIRnEkazipWdL66tm0s91r38cl3E1vzGg=;
        b=Un02IAUxFaAnO4+okYNF13MI+Ce2ZZUBt2hNWW4SRkqOgrweLWFbaWANe4XS4BSQFi
         e/EZQ5wEZzZQRiuNt3vKx3Y4hpzjznXh5EB/2EbXmbfTFnGfm5cJAW6PaBQ9+bHRZJ4z
         LGpyKGeEPgKZxyfJem6YsbOWPTpL6Hg+nMRlcAsvrAhYBL0tQTD0ludcgnx2hn+/ZKDu
         /ZeFlC05BcF98Nv01EwC/tFQqqWTiUKdnXgDWJBsIwf84tbTXET0l8CfDIG4SYlYdKz2
         gRzD2fLPeqWqZRUt99IJwW6NBGos7TNMvQxdEUde3d7iXy3SJ3kqDVUF6SCiqrfRyfcC
         qJyQ==
X-Gm-Message-State: AOJu0YwLOR3ta3uU7tVyIm6pTmdQk5WGDlbsbX6WV8hL1jxicWHgXdCw
	hOKFNy5Clll/ODyZkcOzuCESa4ybRpsk6ceYNgFkA9APEg8aVBPz8ruSG5uZH+aI5xCbk9+R8T6
	eKxnK79Dw+eqeyT/jX1TB98OXU9s15ajkl+8XAFef3DccOhFICj3f5BUqSUaeWzk=
X-Gm-Gg: Acq92OE/cZIncfgjVbEdm+RjLxkbNCVB24Oh3okGZSLkmRDCzK2EUqsgGKzICSJt/7q
	0qYRjj0vf0va9M0cyKmUrtkdzd9NzkyVZT6Lia8ot5kYJk4Sk8qZQsdorktvkd3zCCX/wwzHKsk
	9ccQAgceKGLfxApjMmJuLdKhS3NEYb3w6dw3DTzY/JulLZNclngNAIWFuLewEKm1MvwIFVmuUmU
	ZDQGZmyakmHphYCqlvx8JksTfE4Gc/7rUun1IY4CQR1kaaeLsnyjGtmPrm7IupOd8NbA7hxmYy+
	U0S9QVpMctBdDr+E9Bi7rGUaKen2dmsIpk20VCVwq877gQiCaBdlx93WbGjG+vnhrnq9gkvYj83
	czvGmBHIxMeg2nHQIRXiP4G7YLf+chtFzoGizwuOokzDdOJ8ZIIVVSPBSpOje
X-Received: by 2002:ac8:5a42:0:b0:516:d812:c35e with SMTP id d75a77b69052e-516d812c62dmr29096531cf.21.1779457244129;
        Fri, 22 May 2026 06:40:44 -0700 (PDT)
X-Received: by 2002:ac8:5a42:0:b0:516:d812:c35e with SMTP id d75a77b69052e-516d812c62dmr29095691cf.21.1779457243645;
        Fri, 22 May 2026 06:40:43 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:2fa:6280:a48f:fb37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c600esm44912825e9.3.2026.05.22.06.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:40:42 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:40:05 +0200
Subject: [PATCH v18 12/14] crypto: qce - Map crypto memory for DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-qcom-qce-cmd-descr-v18-12-99103926bafc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zlCDdZs7gUpD6zwuSqo1JfGszglD6fOxI/qdoCA4A3w=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqEFy9GCej0i1Cd1aztfnZZqtnXG3WAa7q9+ntF
 QHPDWveOlWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahBcvQAKCRAFnS7L/zaE
 w+TZD/9vRYP2DEf7Qu75DhCLbQDS2mmmkVJ4+R9oiI3lc6AVdk6u3LDUGd9bYd6FWE1rKOHYVMc
 ax67m1Fw6hUcKQoO3SjAcPfR8emrmbcp9KmC6tuB2d4PGFa56saczmhwcm+WIIGCXM54g0mCT0W
 LQcJEChKGrkdWsR/LL2YGRjKkLBZBP7YK/i/p2hVnyr9aFVBUQ0ERj87TB5Boh7IrjmXmYQ7MOU
 OD6V6n3pk5hletbVoErK/FrvbEJhbU5h5Ib4T2PU0J83jfFNqFUmAY85bof5EqMSTOC9OC6USr1
 Q77NhHZvFQblQkJZH7+qGFQALv9Xp4+c1CgBJ3gKChzY0ME7O5GbW/4p55XCJbOc8Box9+W2q94
 uG1XZvJ5/2gYj/qoO7KjWq0vdO5Fb+md13YyaIrQtmaFWMZlaUB1IIEZ/R2A/YNg3zhmyqYChk3
 eceXwNyVKjTDaVbvNWHH7Ie0P6jG9mebIWguUTA7qNEeg0Hf9NuLkxTqnWkDrzz6gRRVqnPXy7J
 rvDPW4QzOSUkhTiBBKRiFAS6HN/4fZn9+MQTyZbRGl/Fl2qwEGfbXthepOXqviVS3wOJKslnf6t
 6cm8E/jw/pnYRuxt17zrXLvsYnoHzdG57xMDlQ+IEtFs+jjtRIc2e578qqvdkewcL4pmVYTUXo9
 R1+t9Owjk2x8BxA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=aIXAb79m c=1 sm=1 tr=0 ts=6a105cdc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9tNk7rGwWxUH_P3zroIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _0WUNBW3pFtqJOblbwlpvEfC7eKIejy9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzNiBTYWx0ZWRfX/k+trQ3LiaPh
 8rT48D+8dowYEy48PMseEPFZZkjwTFgadl4OvmKI/Pn/QeTpUNT5D1isRoIUkjPEzARW25TiOXz
 mC9akBxVj20CYSU6g+9FFLF1A80nBomNCjWx0kfVYCclzusvkau+ma5O7RAsAqntp1Vo3XeGmWa
 Ve18KdR/DvKdTlwM7/S1DK3hXO7/aAVICd8hkvD6ZhtE7LhsgQCA6WZx1IxqT8O0UypnHl+6iGR
 jlNuo5Tz9BkOuWIjXcXuqudXQrUQ87A6y12dE/44VWWhac6pUaoniCDltfFQcvzWJqXpyQ9e4wl
 tsg2zNS/gYknF52uu9bDkfEmYC78akMLWcA3rivxonuwbolaQBRdI8NJiQfNDPVSq/bUwyzwL0q
 UXXOBOapiQH3/C2ZgJcXGaDBHkpwRZYYsiaONlH0aVQCvI+4nFhqsn9ygPxTjK8u3KTOr5zAT4J
 x8soyzULMRcN4vZvw1w==
X-Proofpoint-ORIG-GUID: _0WUNBW3pFtqJOblbwlpvEfC7eKIejy9
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10742-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2CA805B5EA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the first step in converting the driver to using DMA for register
I/O, let's map the crypto memory range.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 23 ++++++++++++++++++++++-
 drivers/crypto/qce/core.h |  6 ++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index a0e2eadc3afd5f83e46724c8bc3e3690146b86ba..d7b7a3dda464964afe6a6893bb329d5bd5759dcd 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -192,10 +192,19 @@ static void qce_cancel_work(void *data)
 	cancel_work_sync(work);
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
@@ -205,7 +214,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dev = dev;
 	platform_set_drvdata(pdev, qce);
 
-	qce->base = devm_platform_ioremap_resource(pdev, 0);
+	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
@@ -255,6 +264,18 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
+	qce->dma_size = resource_size(res);
+	qce->base_dma = dma_map_resource(dev, res->start, qce->dma_size,
+					 DMA_BIDIRECTIONAL, 0);
+	qce->base_phys = res->start;
+	ret = dma_mapping_error(dev, qce->base_dma);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(qce->dev, qce_crypto_unmap_dma, qce);
+	if (ret)
+		return ret;
+
 	return devm_qce_register_algs(qce);
 }
 
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


