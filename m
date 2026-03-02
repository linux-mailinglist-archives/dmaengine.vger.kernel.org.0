Return-Path: <dmaengine+bounces-9178-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCACCI+1pWkiFQAAu9opvQ
	(envelope-from <dmaengine+bounces-9178-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:06:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF99A1DC5E4
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9AF6319E6EE
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D8377002;
	Mon,  2 Mar 2026 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aQ6hsgyO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZB8WwlSu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7234219EA
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467067; cv=none; b=p6mi+njx9m2hldQm3qxdt3x9xj5FIecX1R7dOsT2ZG2wKMtR5sw0obwjoPlNc5S3YwmGq3XXuba9EUaSqwTfRWVM66obfPmv47Wn8Se5p++bfcz9oXPzLqqYcoDK5uGvHlrGTXsDcXOyMCY2g0O8RHFjENf0HeSJpJtLfdQPh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467067; c=relaxed/simple;
	bh=H6RGZzI1m6Hy642I73fornlozWd6x9hkPKo2H6raYsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVv2tneTVu8G6XU9BzPDhB8ixGUJ0BXQMDX+IY5U5xt4ZkLIVTkwwiN7EoYuP7vO8iXSWEg/RUdizmqS/9hfFE4e4HeDAKg3Njtae7pR4E+ntWtG8Zz/ju9VykWr1EucMwr5uPWzo5pO/D1BEBKGPJIXph/eVf7sLwjLbQIhLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aQ6hsgyO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZB8WwlSu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622CW9Nu2504594
	for <dmaengine@vger.kernel.org>; Mon, 2 Mar 2026 15:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DQ9O/WxlrEXbsvKUWZga3GBiGSWqxH7TMX/h6DSnlY8=; b=aQ6hsgyOrwv/XjdN
	K6Cy1RvPnmTtr8oQNppm7QSEZF9mP1iAI3EE/3M4IRTINiC2ljQ1DugLmN5+A8EI
	f6D9yuyLC6kLqgbo8tUw7owiDL2E2wgdeIpGjG6gX2L2o7CKwaF9v5VOc6SwLRRE
	0KENO3c0sOQXBk/iI63PbC0L38Z+0TRsqwdXzhq6n0SRF2/tnk7c2CSPy+lPFseu
	aNIM671nmsTIEBp6Gx6W0IkAB/lWEjnWoCJt+eDcQyTOWPrfKdDLBsdqiqr3DAcG
	NnYiWmjjykkIZT7ccuroU8D/rC6/lor85rvxvfQiVJ9u2tEieZS92yK5coEANcqB
	sFJWPQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5hesxpc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 15:57:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-899fa82ebb9so75510276d6.3
        for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772467063; x=1773071863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQ9O/WxlrEXbsvKUWZga3GBiGSWqxH7TMX/h6DSnlY8=;
        b=ZB8WwlSuse7BiTXACl5UBM/OY1btuxvzp01Cc70gst60tDfIw/E/tpMG06lAETbfLt
         bm+RkMv5RIJrAYOmmGGdwv0uBUjjpPMC9VwVqukyG7LqVNury7WGhY4EyJXfWl10YHNc
         +zMnhswz0YrCHSvBlTWZ/tomtr1eJKZHJLUV5FnuwexFNGGrk20R6f2V51klENHMnVHS
         mawzgTuZDAvuytzdXGCo4ri3cH1rf5nvEEzZrSNxxSOU807W8HxiV0+CSvFdAfcxiAXs
         PndJGdDAzS70IkpO+Hoeqm5+7SBdeyYdEql94tbunTagXIDHPUNceN9U6ZKdzgaaTbx3
         NETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467063; x=1773071863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DQ9O/WxlrEXbsvKUWZga3GBiGSWqxH7TMX/h6DSnlY8=;
        b=Bpn5IDGZ/dILRQiNOGrPhgv5BIle1qNaOEduT1JT3bzE37UXUjA6dC/iGyvA58Y6TL
         C1eSuDp8b1YUS+NBotiY6EdVw/ujmUDZlqa5F/CSaVGDZxydMgDN0qBRw/4wC5Bp9ReM
         UGEkBnI8HeWvMPwziY6z9eQnbzeGH9gdQqJcckCZ2gYuBxyRkhyYJoL5LiCSsPheJM6b
         ndVfpL9SBaNQ2vPd9lyw38RMYjU2l7WER+Iaj1catnzvp8YlYG5Fhi5XzV1YLwhdSmzD
         eVoYB9q1fQt62K1trL1Xzjd0+h0VS7/PG9UK4fVKGUXKUSd3ISEIxRShLfhENWRp6OsR
         A+dQ==
X-Gm-Message-State: AOJu0Yyr2ntBE76IrlF8abbhqykHIKjfwmPC9t0B6HEhbL4gdPgS+9Pg
	IyHe9KFonD4gRoUlyZYkaLS6xEcgEPAXBwksGYUsNTmXSi43e92/BFIVjCrqLp607TI8HPDLKUx
	Te1m4zuzd91z8ZUGazglCiR3a68PyTRLN607L1jWTh6IiQjau4lMs/kwF1rsCgpw=
X-Gm-Gg: ATEYQzypg0xxB/pBZZt93WF124WKnChBHfEAzSCZ1fu3/+G0TZvbXoek/3HuR1+eT60
	QdVFH31ik7TbRKYrZGw76qEGf69SKTocXgpTBoeyiht95h2c0m+i4pLCFr2LWUjUVegikBvrrqO
	uojmC2jaJPjybKJHdewY+LdmuESCGL8tEzjpD62Ct6PaqQlDK2rZyyVzAwr0KPZeEISE8iCc2lp
	N8+y2bf+EB0qSojv+RgEkLH7n3OfRX/AcGUEpmhKlm3o1iRADZTd8OfWBJAWmqEPnuhdOlZgC8f
	4i/qeqPX83SLXDD4x72O1H3ga9ybBD+pNdGWTt38lB1Sx6wj1Az49MCYLE3YjO4E5Yq62BHU96s
	R8nfz5yFDdErgKXwcvHpHHsOmXhKNiHvne3Gl3oaPL47ZshQCanIl
X-Received: by 2002:a05:620a:4608:b0:8cb:4a3b:5e06 with SMTP id af79cd13be357-8cbc8e222c8mr1398998585a.67.1772467063412;
        Mon, 02 Mar 2026 07:57:43 -0800 (PST)
X-Received: by 2002:a05:620a:4608:b0:8cb:4a3b:5e06 with SMTP id af79cd13be357-8cbc8e222c8mr1398992885a.67.1772467062914;
        Mon, 02 Mar 2026 07:57:42 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:87af:7e67:1864:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b41831easm11282438f8f.12.2026.03.02.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:57:42 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 16:57:16 +0100
Subject: [PATCH RFC v11 03/12] crypto: qce - Simplify arguments of
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-qcom-qce-cmd-descr-v11-3-4bf1f5db4802@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2620;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=TfRVgyaOMZw2GJQ0rx6WhRl0huHGm4mvuAmz76BcVUM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBppbNlZG9LYSOKfu5TlTDseIe/TgDfGHUo+ed7K
 9LnJ2eJ032JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaWzZQAKCRAFnS7L/zaE
 wxShEACbtCvIVVakGFfkdp+go+XnzCkQJ2cVC+uPIiyIvG8vB0m5MYzgjVEEQuizT5Om48orKFO
 Dv9WnyBpd4u5lsgJCcef3LjQuOconyGuIZwzF56VlNnrHG4gRO3FrUMYaEpvDd/avaUZWvXV5Jq
 tRpDzMLe8+l+UfkbS2WJ8xyxBRaR5kqUwrCvzGzjb1V+3BqQR0p+ccdNX7hYBOXsVj3MYawfvf8
 0jYdBwK7B+ilI9Fev2ZkM6IZ495svAEWmEAlqwGn7LprjASLX8pyDX0MJml5ATSMx7W0arufyZS
 3QWunDUcsbD2Jt5g1XYNoE+S0yNDQCs+dTkVP6k0V3+idx2VwhvRuACHCAr8zpO9Ek+VrXGDcUD
 yD1ogpHf7riRlIPLmlnpKYf/wBUgq0P9oGuO58bNfLOqBmGrPzT2IAD0wvaQJ0i6kFqAr91Ip1e
 fcb8YuYR7DSDS46UbMKlzsHe8tAXX8O9H92eJEFvanCA9MbsjYQEAHCI6w3WVOtqJsHzDUh2mjP
 Dx8iMe0vezyl9gWvaradWUGc7T53RoVja9XHFD1UkBh70E9ElXDi6Lub5Ng+JJDs9VRMXS5TbvB
 cpnKz/UMqM9mG/gESnL+YgDvpA8aZt5/UZC/+0AWonxkMHfKY/ixMu2BhEVAesKwHYlP3DO+he8
 4c8t2NdUEFvtphw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a5b378 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=KrkfD191a8oFwBap4LAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: txkexPImG_E2SxmLKP26OB6FC7Ge8ryK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMyBTYWx0ZWRfX68WNnOhDQlSK
 56BI6CwyxaL9vBS74xq8Lh0Busjg0jTS1Ekk2Bpk6+JpJe5enuN92RAXvaVHkk20xVFddJ8KKUd
 Po2PC4+i4oGpFr3USHyHYX67xiDdpX5+SRGqyU2ErjuvuwGTfd5OXjHjyvYDYGLHNgBOicQR/P7
 jcfpozd7xOc29swpnc7PMYr/GAzmo/yZMKBOGu4WmcpcQJYF9UShn4Vris/UaXJqkpa6o8XgPII
 r0RH03f4RCbe4WLSlOnwz96z/1Tq/jtZkHmDZVd8Ufx6Xq0rHT1AmXc/nMbzHxVOhg62cbrpn1B
 mvbRvowxBauYBORlSXHZKh112VA08dEs33cNkdcv3EzERgUNk5pEl24hpi6bNUT6ImRuoK/aDCZ
 h78uVK2qkUw7QzlFDboKx52sYu2MeNyrl1FZNXsQKPF3X7XqrEe/mLDQoLHEon3arjizPIrIm1A
 Ss69//WCXtpUn7Y1TdQ==
X-Proofpoint-ORIG-GUID: txkexPImG_E2SxmLKP26OB6FC7Ge8ryK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020133
X-Rspamd-Queue-Id: BF99A1DC5E4
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
	TAGGED_FROM(0.00)[bounces-9178-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email];
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


