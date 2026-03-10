Return-Path: <dmaengine+bounces-9365-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DPiMZ9KsGnFhgIAu9opvQ
	(envelope-from <dmaengine+bounces-9365-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 17:45:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48625505B
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0727F31DCEDB
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2733A5427;
	Tue, 10 Mar 2026 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oYYy3y17";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W5q6o9Xx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427423A3E78
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157495; cv=none; b=sR/QZpGw+R/u7A1CFAohUPl7Pg5CQ+Fuank2YTv0zhqFuF5o/nB19BnukqnKqrn0p26KwwpCpOlWjGYulQGhLywJaPq7J65BIoyNSr/Y3MoCgGwZOczowkJBt5LEbZzolKRyGAnAgsGaWpMoKy9dFNrf8hNu6OOVZtYcg1AHZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157495; c=relaxed/simple;
	bh=Nz1LGAzCKnFnAcOBVZfb8slxeQc/H+JbDOJrfn5zCw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llASlDRBeStRvKrDHfDtlz7w7roCz/V6Cjp2aWVkH9MQvxOy52X2velynpZUv4E4kFIwTVSj/H8EuhQAPbJsGCg6L4JFrL9mI7g96mTJxmk+SrZXXK1kcqAvl7ReW9tdofYIS/1//qDmUUZnEpnIfxymmaDj+dewz3HuUgw96Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oYYy3y17; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W5q6o9Xx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaSOt303787
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TdhhWrCvUxcn/reedG1xQ5srVVcpowXHdjBHgIUwuPY=; b=oYYy3y17oSxaar98
	oGDG8PFTvxUWuVDN3Qb2C61Fw16gcQGPq+hy/9TQ8SqWe1tmvv5INlkcyQbrRG74
	0QkOEaxDRLd1AzYgKTw4jKbcI59uy6Nbvnn27f6IsKZJ/5H7MeOxIDczLIPuLuWb
	otDHwnvQeo56SLdkglIR1+84GrtDjBdov6Q+ashzk55P1pbBR/d14imzxBIxIQSt
	EagiQnxMlL0IBBaSFRftI2XQY3/wbKOflqb8n05wBjha+VvOsElfVJ+fxdZHZG8a
	PfSy5WNI+F0YlEjtlsA4fecLiVrMbu7g519RaYR8LPnzjFhCZRNl1jOVkmp8glHa
	1ewelw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cthjf177v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:44:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb52a9c0eeso10385127085a.2
        for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773157492; x=1773762292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdhhWrCvUxcn/reedG1xQ5srVVcpowXHdjBHgIUwuPY=;
        b=W5q6o9XxP1v7yllmLzLPaMbQR1F4CyRiCi791XtSxV9Sqg7ZVOu9c+i8Vhjw7Bs37H
         BSSFsHSvx36SfB72nIcpxUQZHrtZujy6CaZKkeILW4g22TrxSGaBW25h2Afn2J25yX0P
         g6ix671lFoZ/ytIkf4xPQ0bNZGIDxqyoddVbKKsaLhXBdPkIyRRxA0I9PjKVmYGOpR2M
         cXd7fjpKxOh+ELECDNuy16TmrGnxFOmgtej9YsnuogAHbcJGXh8EG3Vxh3OOWhMqu1vA
         wlcNbeIAQhCM3WYpS/y5ihD9fNTnUtTrI/FvIJZntK97my7BSCzbtWH8aJ1KIWcOJoIn
         KO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773157492; x=1773762292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TdhhWrCvUxcn/reedG1xQ5srVVcpowXHdjBHgIUwuPY=;
        b=o1/KP8QMESFwA8AxSy19Xcoweiu6mGzHynHMstAK6S+7kUwu6YEDAIiEMgwmHL756J
         7W8EVETBWzWLZHbQnoJg6jLKCxfCAfKaYhRQlb2tCPBgWqyw3T1xOHTyj/IYPGZJ6QJj
         Dd2UavRBtH5j9Hefk+dBNwhzrntWy1F4ivCnWzmsjVsqJ7b4/G3D7D90XwDOq0TfcBEl
         +/22cQB6D4utJRfjJ5iYyY7LggSzrgYejCQ448aKCzXm/F4hbGj3fyBMakte0axSy+M5
         Ss7D7pD6Nn33k0DOAUNvOvrCdXG84b41QtNLtDR7KmmKRyTAnH1Kdz/niLKNJat2df8d
         hv1w==
X-Gm-Message-State: AOJu0YzfVXjFEGvaZ6svxOIyb71FOQJop+NfTyBUOlhNcE/LSZLqbjzt
	ZP0QJeB9KgD3NpQYpSnHoJOHf2n7RrgiSTEOa+2gZQ5lYo6KSFCkQp8whmaT6rZ6IZlYbIgUks5
	P5mn+MyzrRXQR0kXCcfFtBTY8Linzr0gyFFXIPzjOkKOs7Rs4dSMsrAwhAkdTx1o=
X-Gm-Gg: ATEYQzybXPE+lRxnpox/NwK24FcRuRFyDY3+6nddr4NYj62PM8sQSmux3Fra1y740f2
	p64LgTAFNlFoHnP53tye4VyC4hXSRiHF4igO/i3TvU8Hn8Xm/vrwWaxX6KqEDs23avUvLgXnVNe
	AwPMfgMVZlIF5Ns/V2Wc/RPCRY6l8InPA+t3UVeT5tD1smXhtuS+eZc8uzQvUvVRC3wvFjnpzlb
	W/p2kxMVjeKZ4u04O+fJuGOpGR8xyX4XvM/eg4H5SlbVWUnf5mAn+Jc9U1P19JFl3TtLe2364nZ
	RNFpWHrwp/QwwHfsIW1wABDEUafAT0lQm1N803Ml9AS3P98WTEytN4OjuiXPwkOfkio1RT8oFhL
	q8Um39XcLo06ka27/ZmoYsXR5328eKPSrernDV+tU+zX9EbXtGnsc
X-Received: by 2002:a05:620a:c0b:b0:8cd:8142:b7e6 with SMTP id af79cd13be357-8cd8142c5d9mr953922085a.26.1773157491457;
        Tue, 10 Mar 2026 08:44:51 -0700 (PDT)
X-Received: by 2002:a05:620a:c0b:b0:8cd:8142:b7e6 with SMTP id af79cd13be357-8cd8142c5d9mr953919085a.26.1773157490964;
        Tue, 10 Mar 2026 08:44:50 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:47e6:5a62:7ef7:9a28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm35991600f8f.6.2026.03.10.08.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:44:50 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 16:44:17 +0100
Subject: [PATCH v12 03/12] dmaengine: qcom: bam_dma: Extend the driver's
 device match data
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-qcom-qce-cmd-descr-v12-3-398f37f26ef0@oss.qualcomm.com>
References: <20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com>
In-Reply-To: <20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3724;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/m906drTofLPxOtAkNVHVDE5jDZx6cmoeu2XGgbJbDs=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpsDxh7N1Y6/LUAB6rgMLQBy2fmGegjB73+f+XS
 H6XeSRAqhyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabA8YQAKCRAFnS7L/zaE
 w39cD/9RqGzG4curV6R3EtnkB/vfAOAeR08inkMvL+GQu7VsjMxlqeMX9YSZ34C9Upm9RsD1AUe
 k2aEYMRTciSiVvt69uB+Cl+UQGdTuilEJYYGC1R8BF82fUZ3zC0Gl9RPqP7fb3W+yEWX/T79V8g
 7PNuTgJArE3aeX0BJAwP+n+ieUFaWxrFHQsS0K5W60blO7wLoi6dxR30oXs/HauH/hk5lYTcK9/
 07NgugUXc/+NCtEBTQqj9/GJlfha/ChE841UGpEderEXy8kImPzUpY0+OgEKcfYajJ/Fb7yJRqJ
 vbAqohB4e+3bzw+Zd4ASagZ32iHInCV3qQBWUWfgKn+Djxhzcnhb4wlw57uJFz4cK9UhynQ80xE
 vGlPXjqKn1aJ0+4imN6USi5O6IEmxW4yaB/aR/+o5TQAUQ4InecZ1MQXlJyGfnutxxxsTV9jKVj
 XhCeOmkVwk7bMojrim+tiBCtgF5rn86bJ6R+6dAjt7KVaaRzqQkwRTEtsFNSgZlbc0cs4M5iHka
 89rk4jkCkz7xtCLDVOYsD9bE317ofSsMSej0LBvRxWygChlJZVGtpMpg/JGMpt1PLKq5oaricR7
 yiu1UcJGSmBZNOYwGTZ2ZMfBsJzyoUQmqfIziE4m2LDTMeqVbpqRiSFXFrdJ3Q+J57Z92Ld+JpZ
 oJUgYOZmN1GG1GQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: Zflq6PcDbTchg1xdLv8PP-C3L7Kn9mJW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzNyBTYWx0ZWRfXzUpLg64MEP/a
 3nStTbxAijqBF8m8mZ+KJFk4hxZF5cgYxOkP6WI+sh0/Y2qQ+FRyuin9cD+dHh7AIzIdQlPdrKp
 NFIvGuAUG1isZPw+00VFe/iFVkW1F09LKenrz0TiiJ/ne1XGqnGfG2x96NZdg816A9sLupflxIz
 8n8gzi1og00g6oTY08kDdkn2aGlq9d0JTEYnlBCpUNo7zUNBcdodSBc/KWS9Ij80NSU/UOwyZcQ
 IVyhHFPSrPWelJyXBaBlmJ/KuFodLNvaowx+ygngZxnvKbE/XH5zv1FEBYEk2oKU7yUKBETEYbK
 u9PDcGJmYyD23rLDJOzb0x1SGEjSO0yal+P0AaU/sR+hHEr2GTNJd7uCVW2Rg++4PiIrYHi/xi1
 Iqzg/lk/Ytld6L0+O0Ld75WREsf3qlMs8avuZSeWoMF9ZWelN4uhEFxTi5Wz+vlxMGM+OtYvrem
 gB1XlIX4miqzfrFJzAg==
X-Authority-Analysis: v=2.4 cv=A71h/qWG c=1 sm=1 tr=0 ts=69b03c74 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Fb6uNmSZeVr-t7npd3wA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Zflq6PcDbTchg1xdLv8PP-C3L7Kn9mJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100137
X-Rspamd-Queue-Id: CD48625505B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9365-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,linaro.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
X-Rspamd-Action: no action

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In preparation for supporting the pipe locking feature flag, extend the
amount of information we can carry in device match data: create a
separate structure and make the register information one of its fields.
This way, in subsequent patches, it will be just a matter of adding a
new field to the device data.

Reviewed-by: Dmitry Baryshkov <lumag@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c8601bac555edf1bb4384fd39cb3449ec6e86334..8f6d03f6c673b57ed13aeca6c8331c71596d077b 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -113,6 +113,10 @@ struct reg_offset_data {
 	unsigned int pipe_mult, evnt_mult, ee_mult;
 };
 
+struct bam_device_data {
+	const struct reg_offset_data *reg_info;
+};
+
 static const struct reg_offset_data bam_v1_3_reg_info[] = {
 	[BAM_CTRL]		= { 0x0F80, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x0F84, 0x00, 0x00, 0x00 },
@@ -142,6 +146,10 @@ static const struct reg_offset_data bam_v1_3_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0x1020, 0x00, 0x40, 0x00 },
 };
 
+static const struct bam_device_data bam_v1_3_data = {
+	.reg_info = bam_v1_3_reg_info,
+};
+
 static const struct reg_offset_data bam_v1_4_reg_info[] = {
 	[BAM_CTRL]		= { 0x0000, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x0004, 0x00, 0x00, 0x00 },
@@ -171,6 +179,10 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0x1820, 0x00, 0x1000, 0x00 },
 };
 
+static const struct bam_device_data bam_v1_4_data = {
+	.reg_info = bam_v1_4_reg_info,
+};
+
 static const struct reg_offset_data bam_v1_7_reg_info[] = {
 	[BAM_CTRL]		= { 0x00000, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x01000, 0x00, 0x00, 0x00 },
@@ -200,6 +212,10 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0x13820, 0x00, 0x1000, 0x00 },
 };
 
+static const struct bam_device_data bam_v1_7_data = {
+	.reg_info = bam_v1_7_reg_info,
+};
+
 /* BAM CTRL */
 #define BAM_SW_RST			BIT(0)
 #define BAM_EN				BIT(1)
@@ -393,7 +409,7 @@ struct bam_device {
 	bool powered_remotely;
 	u32 active_channels;
 
-	const struct reg_offset_data *layout;
+	const struct bam_device_data *dev_data;
 
 	struct clk *bamclk;
 	int irq;
@@ -411,7 +427,7 @@ struct bam_device {
 static inline void __iomem *bam_addr(struct bam_device *bdev, u32 pipe,
 		enum bam_reg reg)
 {
-	const struct reg_offset_data r = bdev->layout[reg];
+	const struct reg_offset_data r = bdev->dev_data->reg_info[reg];
 
 	return bdev->regs + r.base_offset +
 		r.pipe_mult * pipe +
@@ -1205,9 +1221,9 @@ static void bam_channel_init(struct bam_device *bdev, struct bam_chan *bchan,
 }
 
 static const struct of_device_id bam_of_match[] = {
-	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_reg_info },
-	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_reg_info },
-	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_reg_info },
+	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_data },
+	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_data },
+	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_data },
 	{}
 };
 
@@ -1231,7 +1247,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	bdev->layout = match->data;
+	bdev->dev_data = match->data;
 
 	bdev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bdev->regs))

-- 
2.47.3


