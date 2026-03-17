Return-Path: <dmaengine+bounces-9483-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOXIE5BfuWmrCgIAu9opvQ
	(envelope-from <dmaengine+bounces-9483-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:05:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9902AB687
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74B753072D95
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAB33161A6;
	Tue, 17 Mar 2026 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="egUMiK6p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fSGdacko"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A63E1223
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756164; cv=none; b=DiUo5FdGzU2oRTnVI8TesV9qbOlCfUYa+06dv5rF2MRSIcMetdrGwpTlX4U46rVwnW6Z4ENJZs5f0qfaGB49V5ZsVpqvIcPBmQoRxrV3IbIyEqLIOXufJPZsJ8yvEtSyudn3U11SgMuqUaFLkE9cnwyWj26Hm/JiZoi32FlWNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756164; c=relaxed/simple;
	bh=V/kExSnp4gLekFUspVMuJp40Wa32cu/zESSu6vck61c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKsJzTM4URJrl+xCPXBcAH5mh2f/v9z3j/bMSVzrdT6v3K2KZJNEgtj2yy8JL9IX61Ux3FjftAWBjGyr9sin0Tg79GSgp1csn6iyp2rP5CWYtcw4DTAYM68BHGo1ishYCs6o9Mvvh9ee8OzYHZwAdua4aaVA+NJIBXZxyhTd9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=egUMiK6p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fSGdacko; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HD4wlx668927
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OOwdxQEYbJ9Or9A0mYUFJoOOp6SzbaWszXsvmPmeoCo=; b=egUMiK6p95gLK7Ec
	5yzvhek1Xp4HHsGJLveD9OYZn9s+ZM88kQOuR8osYzh+E8bXlTALwGwdq1FRyBLN
	ib244BKpyu7pqR7j0/dR6+Et3+mE0LrObAgi28O3fkJv7s2CcgQ9gr/YpzBpqGy6
	d+hog4tSifnJv2iwJ124JwZ7ORfP9/56xQ1dWsKl9/g/Ttwmklh5lXgJvSPLe87d
	q4hxzdwBouGbBEaXe8rIcTf1B6QW59VKt3mPPoIQLyCxyZqKP8jdonofAeLDiBON
	+jx1IBxeMPrSbQCwgsXPyVfUMO2k24/FS001m6J98GPzLByiDmwaFetjymtDYtZk
	vE7nNQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy7he06uw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:02:41 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94eb4245732so9193556241.3
        for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773756161; x=1774360961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOwdxQEYbJ9Or9A0mYUFJoOOp6SzbaWszXsvmPmeoCo=;
        b=fSGdackodBuu+9cc/H9jATPN6YHAhjJNko9X5N/jJOOALxwsfm/dUi3s2gS1kFVsKb
         1+IuXnR4vkI8LWb9cGSyoc1klWYIy912DlC4Q8lEMoTIvVFtMvBR9mcvWOzYPaiEdCFn
         LdkLpCbVSy+IBi6G8i823DAfDv14F0E9PljAxGR9aEsYe/3tsxIu4nwnIfcLbUEP+0kJ
         VwTwYbilRfo/sJ9NstidkTf80icOMUqZXveFGCGuS6jlzIMMIPNKM5UIRX92iIVASTuv
         KbiU+A+dqWXQRErXXUDoh3LkZXuvOH0KLoPQHysFeG9pVTxr3Uos1aqNLpbfyKKaZIp7
         Ks5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756161; x=1774360961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OOwdxQEYbJ9Or9A0mYUFJoOOp6SzbaWszXsvmPmeoCo=;
        b=ZfArrAdBA9U0EsxShRQDUu17FSygCo/iFQw97Iyj7mLYjnLUV9h9vLONeCt4zsIqzV
         ovYutz99K1S/b0E7d6DJH66bTKay0ID5xVO8HGbPR/JPoj58UVcraA2ua3Bp0ugILp3+
         uA5okzaatnILKum/ZbxfodmFh5cSElXUQMzlPnC/yytVvOpKISX9zK5+LAbcrvIuVjx+
         VJ97KnrMNXIcvbtT422rjXclCrBM4swpVguIIC5H8uEVd/8kOhlJYOaPCRJzRLrjBadd
         FBu4HlVVW0v0PReE0AFyEG6pa5VE6TdNBqT6W5/V+7hhV4iVEP5uYY/eRVcbB2eLUJNN
         CjSg==
X-Gm-Message-State: AOJu0YyJhuCA4c4E3GWOm5XaaMXFAkGWchOZSZeSEjgkpn+G48aaNqmR
	KOQEqq9n9ExQ/nSNSTxrybyozGUTphMJBKgki81S9WGhV283kg/6kjyhKjacIwiXRy7J4N1vPXH
	7Q+Ifxov1WuTKuj4u95O7i6f1JTJKrxUW/T7CNLKoWdP022NRQldKx+EtBoMSTCo=
X-Gm-Gg: ATEYQzyH0MwDKw6IZq24ddzFGjrJfzfT17mACd/yCanfWrFBGpItTlGYvfyVLivb4o+
	mwUI+AlJEqBkZ7gU8XaBhACYjWE+US6bmPhFxXCsVY3LTym/iVkT134pmz6xok3bJeeSFnAz7YI
	nrH2ZBahkQpqf2jcP6uJL2lho2sS9aW4fTvQbOeeXtfID/VZtS2w2Pwlwg7cKNc5kjGu9/l6Y/b
	8SPI+HcQ+6aVQfwPRr/P4Zv8ZYcWa55VSELVYuskCWcIAolQNw0LB8SZsSBxCwKeFzRl7WarfbN
	557f4UAWc5dctFDguCkRA8HoKKRQgzoNaG0/2ntvjnXRyVZ5ePfL2h5eGhYW1RU7fe3HvdmYROF
	WkYTp0Zfx3n3kVTgaQ4LLn/HHKlURSbBFbtE/XD17iyH34FiGLb+Q
X-Received: by 2002:a67:c994:0:b0:602:6e95:bc82 with SMTP id ada2fe7eead31-6026e95d27dmr566472137.33.1773756161183;
        Tue, 17 Mar 2026 07:02:41 -0700 (PDT)
X-Received: by 2002:a67:c994:0:b0:602:6e95:bc82 with SMTP id ada2fe7eead31-6026e95d27dmr566403137.33.1773756160622;
        Tue, 17 Mar 2026 07:02:40 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:6aa2:dd35:4d6d:8eec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b4938854csm9359709f8f.34.2026.03.17.07.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 07:02:39 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 15:02:08 +0100
Subject: [PATCH v13 01/12] dmaengine: constify struct
 dma_descriptor_metadata_ops
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-qcom-qce-cmd-descr-v13-1-0968eb4f8c40@oss.qualcomm.com>
References: <20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com>
In-Reply-To: <20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=V/kExSnp4gLekFUspVMuJp40Wa32cu/zESSu6vck61c=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpuV7wh7HuGH5/DCVeb0SkWUTqB0AF86dPpu7g/
 72XbdlMm+yJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCable8AAKCRAFnS7L/zaE
 w9XrD/9DdkZCvQqumSRBF+lrFXBsxZxYUgEXfN+mreAzhSLJYbs41bwA6vMJqx2u/xa74pIHcRI
 E6X2kn+0sMgaqUZUFnbGghcb8lvX6u0/D3PPxuDpMbrRK41KGkpWrVqK66I2pMLSGbGAGqrb3Jm
 riFP3OW34JDf85ETjMlsvsSkhvH1vQlbhjrb5zKwExnzF3ZhyFsp/Z6ykcJfudt7pgsz1e3Qnrs
 CxaJXHaW8VVAg700d6BOQcZJLJwiz8WZvl19u6ls+uZpp80IbSC0N+b9W3KzYGGpPJ7oC/UQeGj
 Rm3VYVFcUVta9/EolEJKIDs+GKNzfWUYN6/Xh6bRzLzhIWcU/QvdjfzCY73ViQd3x62jGrfst98
 SiHa74zHS1wdck0v9ZVzg3z5qbhjH53km5ewIJS9LWxG/h4ttLL1HKFpunJMxnSa2p94VfYrwVc
 IloeSDr51fePrw3ldchplm+0St42EqZzB05sgomDRO+jcnCc3IqYuffFALsoFTEbOztegE1k8Bd
 KNWHtxAyws1j8ykk0purkFy/LdSOKOUiBw1G+wcFznNp4NrFZF7GhGcUYYfsjcuIpBsDc+aDk5W
 3SAKF385mi9hge5rDMti7WMIqSN3jU/WMTo/z3CDmfJRSFJ8fRaNxrTssIqdHVODlc22dJWP9/N
 UtxRbRqtQMgBn9Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: JiivsQzmIenHrHdZawn-ulzdgdTP7kPn
X-Proofpoint-ORIG-GUID: JiivsQzmIenHrHdZawn-ulzdgdTP7kPn
X-Authority-Analysis: v=2.4 cv=QsVTHFyd c=1 sm=1 tr=0 ts=69b95f01 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XeVHrwws4l7kqE2Ex6IA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyNCBTYWx0ZWRfX6/kysBJ8rpTc
 PK/vaeFurcBvza1TCC5sufb+yXlsVTgCcpE4eDG023CGeHhWqkVSYzqg3ZHtPDwAQDS2WCVFi8Y
 yX0va5YRbUnn7uXhxCFkuLrHSbYIKIBiSOpHjXF5Fo62c8787wLpJBvpU0Tmx5LsAvhPaja0pVA
 PcEOHLvVW2mQPoGdZSzp8JR7eXN3FUUQ2QS5+DsE6bU+2kXNBW5VuWuNGkwjY1BFM7/oOi3TTSB
 PNd03ni3KEAk7gpK0jBr+g3ouNSuM4gzhqkpAGlPnV2fKzxKwYv9T8P3vK0bWkJ+feDw+8twiVP
 6buzLBSGvDomKWtfKn8fyWq5VLmvl8NgfVv1aOGUXV97J9svFBZtxqfB1Mo78kYtSg+/kSgR00H
 N1aqHwxYqGh2QTz1qq201Pgo//9lnnrmXrprxw9fm/hEta1ZdggQ9bYj4G8/svWduZn66+i2y0S
 7notk2YXbaSeTPPr4CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170124
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-9483-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[qualcomm.com:query timed out,oss.qualcomm.com:query timed out];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[qualcomm.com:query timed out,oss.qualcomm.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DF9902AB687
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There's no reason for the instances of this struct to be modifiable.
Constify the pointer in struct dma_async_tx_descriptor and all drivers
currently using it.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
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


