Return-Path: <dmaengine+bounces-9182-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL6XGZK4pWmDFQAAu9opvQ
	(envelope-from <dmaengine+bounces-9182-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:19:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D931DCA06
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FBFE31BB0C3
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA5F426ED0;
	Mon,  2 Mar 2026 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d19viBf9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="am90d3ok"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E3423A88
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467075; cv=none; b=aXfHwAEIsazw/pb4LJ5gSj5gBdbEHKqWR5boK18DgC1KI9fs8YWwAP3qFw3Ati3LWdmN5hf9aqhoCsrhzQUZnIxGNOXSRc7q9h092qiRnPNHz8XR9j/aMSNoGbefPZo16vLkp61IcoRSlQTzhQLhj48Lltf+vFd8pJ1OKvAd7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467075; c=relaxed/simple;
	bh=huNQ1yJ9Jt+LKMpc7zrStUQQmAlHoApmhoOAR8Dvs3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjNRsmGlWkZaXd98TfhrQ+86f64p7AaWswPxYg+cLgePhgkilGnupHPF0TrGJbOsRbNXfLTcLMTruFR+5JfHIkYWyVjdmtXLOiFbBHdiclGG8vMNYYfFyJL1/uXWPgEdzm2OG5rxVqS0RWvPe9tdEuw1Ba2wIQrq1rov3TL6dIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d19viBf9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=am90d3ok; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622ElrXS2048888
	for <dmaengine@vger.kernel.org>; Mon, 2 Mar 2026 15:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GTF3K17Z/loG37nN0J9p8Kv0gzEEsdZss3KIPasgllI=; b=d19viBf9cUd5JOsm
	d/xhsJktuB0bZJ4LhQnmCsU3r8ut0mZSID+FgC9NiO5rJ5Yb63Uibm1a7UVvQ4z/
	AzgX45HW1fh1qgqR6mWazVyx17wIUWQ9+/LoQjZ/8uf8JOfMQChH1Q2p0u/xT18u
	jSJNpyrkS691DqtErOVy0g0iGle5FAS+DzYozD/SITDletOGn0wQlffr7snjKR6C
	BHafayLzonwo+X2pCE0EH3HPtdge4PvEWkX9Syaf9fO4Gp9+WA5BN607hO+Mi9G3
	uKHRs/H3qx11uUudgfkO3Fg6Jb1GYK4j0klNxLat9iyL512dbhyRwMLdknZiCcvg
	qu2q8w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cncmfrajg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 15:57:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb4b8e9112so377147285a.2
        for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 07:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772467071; x=1773071871; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTF3K17Z/loG37nN0J9p8Kv0gzEEsdZss3KIPasgllI=;
        b=am90d3okPMJsEBwHsvG4U1vy5BNmT9PsLwX1fEWvgbHikttvqQn+XKWkyWYzxMpY9K
         tI7OLgD46lzSfhEvlmHY5Ir6b0wKpqyB5xgqxisrNHLNpDHrYNVYUzJB8L8VbuQimoKE
         3PbDK2FctI3jYpIYYHWJKiazbObVu8G0GM5wPfYhsV7EnsPAC1fpl0hJhTZ5fzqIM3cz
         mdGWFBaqlUJ3/vUl4aXhiuwpQer+exXqq3PqDS/RmB6GoquqxtR/IyCa+8JfhoribHUW
         ITs9LLkiI6Fwd8qBv5Q4d+FgyFpZAmac8B+LqHROrQr/CYiPWQMkdN2w2oIMvrBmBy+u
         JVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467071; x=1773071871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GTF3K17Z/loG37nN0J9p8Kv0gzEEsdZss3KIPasgllI=;
        b=xEgIUH2BNZfeF5ej+JDan9s3eIT0T+UJLH6sfDU2GHZ4r56k5STWQBhevBYtF50Mzp
         AZbM7mRIv5zzMn9mON3lrRouuOnig7y9fqI3x67TC1NIfI3c3WnE4p9jK+9qdUhQW8oT
         QmjMeWN3ybPBBE0kQaoFswVWLQVy+zIy93TH7H7h9ihzkTSHcHq94DIkcf7iEn8VQS7F
         MBxvi03nQ/QJOnuj8od4zYVZ8aUC3qIig/P6IXTnWUz7VpT6KQQG0khONtRTbSDHVHl1
         Nhx7HBCKrVXN1c1E+2tRyr5wX26RQt57M32HTqK7t10SsR62PbKwvhYjbc4U4Ujr2muj
         B3ow==
X-Gm-Message-State: AOJu0YxuUI6eQlaCEZQiftkWyB86w/gTCZFN/vkIoZDSPDbwKh5ERWgA
	CfWEo712GmUrcpQmc13IZyIYcZyP/SNThNpnQD0a1Bf3cFktBgrflpbdrc0CoHYfRDmzEIwcsnd
	U7qL0xcpNalAvFCMDxVT9688CghusOLvlmmUAPKMJjkNEN3gaLUtyAebw/eW8x6k=
X-Gm-Gg: ATEYQzwVWVMMSLHN2rGD6K9rej3yEpyYhCi3FWpWNrnW9xVjNDQt+4FtFJ0KJYTLMry
	tmcn0Wf17QvA/Ai82rC9R8xgJqrhbgTSRnroYFbmautm5C2lmmqpv8d5/jIFU9cxjXFx1ryEBUu
	mgN1THGEsN7FfDk56N/gY+NRufTiY1MElkkNO8uvVH4q1BSb4z+0V/PL6d/uGspvVeUMzWp4keI
	CcWOXZip/Ox8z34bJLHGXtzlBe2X+dCdPtA+s4rN4R+tdIo4YSYag4bCadh3k+VOOVwrDXUyqIC
	w2xL7xGEyAXxdfsuIr8LzjKV85kQ1+Mj2XD4lWlLjAOyV9LqxYGQ3C84M3xuLThORPbu/Vh6T6p
	jORdfI+xmskNEVEgqbpTAoIZUriTiSuzDx15AuMtA4+74TBVQMNGn
X-Received: by 2002:a05:620a:2a16:b0:89b:9b75:f5f1 with SMTP id af79cd13be357-8cbc8f1564emr1570334985a.53.1772467071036;
        Mon, 02 Mar 2026 07:57:51 -0800 (PST)
X-Received: by 2002:a05:620a:2a16:b0:89b:9b75:f5f1 with SMTP id af79cd13be357-8cbc8f1564emr1570330785a.53.1772467070508;
        Mon, 02 Mar 2026 07:57:50 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:87af:7e67:1864:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b41831easm11282438f8f.12.2026.03.02.07.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:57:49 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 16:57:20 +0100
Subject: [PATCH RFC v11 07/12] crypto: qce - Communicate the base physical
 address to the dmaengine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-qcom-qce-cmd-descr-v11-7-4bf1f5db4802@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=huNQ1yJ9Jt+LKMpc7zrStUQQmAlHoApmhoOAR8Dvs3Q=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBppbNqkO+K8MdcaL+Iq6maaBsACCQxJZeE48tEz
 jQGa0foWVqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaWzagAKCRAFnS7L/zaE
 w1yxEACN61b2eBwGFN4Xz7RuHV8ss8EeNNW/vq2TM6zZ/jPXhTyII117kppB3b5qNpaGJz20GnK
 dWRcJ1pJfW7u6bbtUcWyWNYrLj6MsB7qIUUqsE05hJMDxoCgUgCjLudN061h7/2pSF82wKsZTh5
 vkS4PdlDZuq096UVrubrkJX7nTZTERvO0Gr+qrUIDSKTysJcO3aZego6U41L0+ENNLYsviQgSIT
 qCAb0F6j5z8VZLVIOUDslPf/fC24OaG1c2fHMlNmvRHX/Fy1JzCYIW1z+ozscoG6iBFOBZ92mB6
 y4oLivD/Uh/AnB9gjkXUKQ2yG/1kNfXyT5ypqgrYWRZ4WFqcyrySrCWMQZ1Ja5lIDzbaw9tYAXC
 Op7zvDq+Aqf2NqKG0i72xBTtdUHsA5ha9D5mcOfppMIdC2IScKvMB7MUFDtp3DKiQy1WHeIzeUX
 uCSHJ+CJw/qTH6D5yh0ij5kS4ZLEm30P6Ok933D3NY/Ba2yOEj+MxC18vhWK11z4XN/zzSJ03Ve
 cf5JH7UXZnz3dmamrVE08YCBAqLX9pKTjvZ+Y8HVz5klOWx+dZ4YVfVF5DGrmH1YxS/h2wiLBz0
 7a4hRu1ACC15yEpuj7qc7b6Npve2UzyhgUQxfXUlZ2L6RR3chm1ccSZaF1NEtNWoC1PzPz3Qjeu
 0qZ0jHqMtB27R0g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Br+QAIX5 c=1 sm=1 tr=0 ts=69a5b37f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=mwBPi38BU94uBFWovtUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: N1qgOGeWswalWCjI28UBHWJCgseba6th
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMyBTYWx0ZWRfX+36LdqDxq+5a
 dydmDAML8QZ1Wc6Lt8BDenlDUVUjqD+qRfVYnlUAK8Zznqdg/AAwQ0iTG9dH8T9tXFS5LUn8jNs
 Ec0+96hBdp6rwara/7r6sRwp1h4AS9JEGXK30YmEMRhBZUoPhv00rT7pXtHK9MkjqMnhf0PZJWV
 FF2KdSCo9F7LKE9t4SML8R2zTNjhb37Y0hnZ4WFIosfBcnM13aZbYz0C4zobCTEoFBN/RmHrh1+
 vMj4N3vjpY4PokqkbTWVs2Vn8LaQZqviJB5v+P9XOgPCVvezGlSXNIfXJ6sHefJpN80DOEQ3JqC
 40RZLFHNFqrO7GJqI5VD/DmVyIVqGiOyr8C+PaRbrQH9HPg7cpjTYfO3OHLivF3QAEhDGD6MPKm
 uZ33HR8WV4oWkXsFnQfG/PbiG2eBNsLqCyi5EOTei132MKbvyyLX+7+EJwqv4XZhFBrIvU4Utux
 F7CfaHqhTeBbFx7ptdQ==
X-Proofpoint-GUID: N1qgOGeWswalWCjI28UBHWJCgseba6th
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020133
X-Rspamd-Queue-Id: C8D931DCA06
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
	TAGGED_FROM(0.00)[bounces-9182-lists,dmaengine=lfdr.de];
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

In order to let the BAM DMA engine know which address is used for
register I/O, call dmaengine_slave_config() after requesting the RX
channel and use the config structure to pass that information to the
dmaengine core. This is done ahead of extending the BAM driver with
support for pipe locking, which requires performing dummy writes when
passing the lock/unlock flags alongside the command descriptors.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 3 ++-
 drivers/crypto/qce/dma.c  | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 2667fcd67fee826a44080da8f88a3e2abbb9b2cf..f6363d2a1231dcee0176824135389c42bec02153 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -211,6 +211,8 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
+	qce->base_phys = res->start;
+
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret < 0)
 		return ret;
@@ -260,7 +262,6 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dma_size = resource_size(res);
 	qce->base_dma = dma_map_resource(dev, res->start, qce->dma_size,
 					 DMA_BIDIRECTIONAL, 0);
-	qce->base_phys = res->start;
 	ret = dma_mapping_error(dev, qce->base_dma);
 	if (ret)
 		return ret;
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index ba7a52fd4c6349d59c075c346f75741defeb6034..86f22c9a11f8a9e055c243dd8beaf1ded6f88bb9 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -109,7 +109,9 @@ void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val)
 int devm_qce_dma_request(struct qce_device *qce)
 {
 	struct qce_dma_data *dma = &qce->dma;
+	struct dma_slave_config cfg = { };
 	struct device *dev = qce->dev;
+	int ret;
 
 	dma->txchan = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->txchan))
@@ -121,6 +123,12 @@ int devm_qce_dma_request(struct qce_device *qce)
 		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
 				     "Failed to get RX DMA channel\n");
 
+	cfg.dst_addr = qce->base_phys;
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


