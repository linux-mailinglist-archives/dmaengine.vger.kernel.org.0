Return-Path: <dmaengine+bounces-12479-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xo8cBZoKVmqQyQAAu9opvQ
	(envelope-from <dmaengine+bounces-12479-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:08:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9F753374
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 12:08:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=dWofjQZP;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=EQLxPmsx;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12479-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12479-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F42304D706
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 10:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C0434E75A;
	Tue, 14 Jul 2026 10:06:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B335CB95
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:05:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023560; cv=none; b=uNSkQ0pvbrjyMaQ232ET/bzwaum5IkCDW5Ez6yx5VNzi4EOw+8tYc41f8K8apIVRsV6HABKu7NrEBWWx2ACl0eQJ9wv3+eE9vkee7D+c8MEPKckXLacv1HB/DyzmBfJmw/RXEuw9lCm7rJT93fTzn3r4Z0RT+SauIzig9HbSY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023560; c=relaxed/simple;
	bh=k831T68Gle0Et/tegpSdv3VH8qV/0hMaO9J0ZRRoz4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fi6EvFjToxTrOqhqiKaUCrfCIW+ccsgSpU6Pn/noYcPIRYZOKg36cva2q45taZjvPUEHAiWLhW5lyOltaszSeYhf7QP7kXVIHHjD1APRC1rXdtA2GLAvfldMNsf4WU0K++SCSrbFf4h6KtoLtq41xTy6Fbm5qmEzGLXFnvS1vMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dWofjQZP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EQLxPmsx; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6SYk83929189
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IFFnCORgu0ZMvRsu496LBJcnkWBVb3pQrobG7T1jp38=; b=dWofjQZP7fGALbna
	i7PSVxCv+C6ATCHe9RqkWugyUg2MU5Sbyn9Q0T9urtRVsvPxjx2s+RX2MzPBBwkG
	F1TtNVaFDYdV/Zw9/cEj8IWiNdR7nosJvuR/fefh4Zm6/Sci2SjVaQCMjwPTkvf9
	X+mvwcFUeyWTjRUS0VVWUZIUl+om8LMJMlJUBeWzslZB9dzy0cR3FtDdCYbpBxRE
	mEFTckURpvRb/RFXzvyHgheIY5kwQxAPliZrFKb6ka3RQgCmer40wgWmaDDlz0Ik
	UXgOW6NZlp1zyJCgPqrf58HDAWP5TQn5aiivkZgVTiuMOCoZKw2NXbwROEXfIxnA
	IlNXhg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd37xbf6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 10:05:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc8bde6318so77911695ad.3
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784023558; x=1784628358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFFnCORgu0ZMvRsu496LBJcnkWBVb3pQrobG7T1jp38=;
        b=EQLxPmsxwofMSi/i2lE2ueqKJUFTLlFcZkOZLjGgEMXn/2DMrlfE1QWFRShoiSpniU
         vmBYEbBk+oNIj94mJC8Hfd4JrjGHHJXuDnOVUCGrjOHHAboZ2VwMbsChqy+0gDBt5oHC
         cyW9je+3dnBhslO+USM4mZKseBPXWA/ALm/lbipC1gvu/P3wi5B6E4jRTTcBlLccfMFI
         6aWz6Bk/4zsUbF59i1NuALcuasMPggCDsU7LiFjvdh19mGiJf+Iy37AqaQv1OE6oM7fh
         ZC1MEnve8T8+7GMnrMFoUu59d/6LSF9EtzhjKGu+XgqbZCi8Vrp6E3mSZE8DFmF8ZKSx
         hRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784023558; x=1784628358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFFnCORgu0ZMvRsu496LBJcnkWBVb3pQrobG7T1jp38=;
        b=EnuIoUi6b0zIAT3x2mqdc0GKclLuOFhE9PJi8iU9FYiAFqCnMm//I2fs3x1xy9eGfr
         pvai8ojIoF9nC1GHwrV73N9xfsxaQ5XUohn2x6JTUJWdC/hIEkphaC1XrQK4Vnt7r+1K
         cSDbDmXVacr6GpRhNdE/VSDu++MIakgtHZKhltZyoCdFg/QKGxfXsZwcTPrLJU3ierh4
         F+mjSkXXQMLSqS/5adiE+KqvemURUrhMRL0L55qijpY0165RU+mo833Zy0CKRY7odgMY
         pgq+CVIDzhjp4CJnFDIt0SN6Vn6lfIpbRGgOs8y7bE4AnZXQlIuj1TwWwi2BKB6rrLxX
         2WkA==
X-Forwarded-Encrypted: i=1; AHgh+RotEwc2DZZtt5Q3xeBy02w0jBlVOzGHBvBh3ZephDc1mKu56n1IpcMA6QeNlzogfj4eskkSDZGwSOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3swF5skFf5RDJoIjBzXMLYZzuVsHWKtHoK62PJZ3PYT9ydwVL
	pt/V3m95gtoWnmqkTrlQRLcP0qWooFgDJdqk8kY/Law4nEux+PGaWf2G33gEw0oN55fV0zqBmRk
	a7B5K2GNF3oqc1QHm0wBJAQ6StziI8vZschTmh5772yDPUR+XmF2t5qE+uYq/pyM=
X-Gm-Gg: AfdE7cmtHv0AxYEBIVf7oFOBJyi0zzflPcv2wOZoi0uAAY22Fux7wvVkBotgMyuPQgb
	4etznKPGpiMSxzCGpsjSFstbrLwn92pe4maRD4dpsyz4BJ0gx1gUTqnWF1ynh5LdbhR09MbNx3v
	OIDOZqcw9o3dZIqg4GSmi+b3kDyUrK7l61ZlLSWvm3+2Cf1gth+qV5vCrzBLplf13COxzy1MfKU
	dVTaLtuUKaP0FQt1+3aNCFYafRx0E5j8Tw36Zj51bfbq0SB27qNoWNwMY1Qps8jZLeXUzKII7px
	EV0E7WquGyFlcV4ggZHrq/Spb51QuutzNRc/jlA4YN4DwRb54XB0+xSJRlJg5pPMt4v2S8sREiQ
	y0jt4XD7u/UOSwqniY200wTgjwPnE36ZPzIM+2fzgQjoy
X-Received: by 2002:a17:902:fda8:b0:2ca:4b7a:4a02 with SMTP id d9443c01a7336-2cef1370d34mr17545935ad.43.1784023558314;
        Tue, 14 Jul 2026 03:05:58 -0700 (PDT)
X-Received: by 2002:a17:902:fda8:b0:2ca:4b7a:4a02 with SMTP id d9443c01a7336-2cef1370d34mr17545685ad.43.1784023557915;
        Tue, 14 Jul 2026 03:05:57 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf737bsm112653485ad.19.2026.07.14.03.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:05:57 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:35:14 +0530
Subject: [PATCH v4 3/6] dt-bindings: crypto: qcom,prng: Document Shikra
 TRNG
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-b4-shikra_crypto_changse-v4-3-06a4ea97c209@oss.qualcomm.com>
References: <20260714-b4-shikra_crypto_changse-v4-0-06a4ea97c209@oss.qualcomm.com>
In-Reply-To: <20260714-b4-shikra_crypto_changse-v4-0-06a4ea97c209@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfX21fvovzGvpp7
 dEIIT8CJmBFk3KLQo4HZisOmSvP+hJ/2o+o/ty45u69+IZjSqsTNooLk7q3eCgLWwyqTrUdY7hL
 YZdy+qSrdKcJPyoK5S8dRSAkxT5SsvCBDTVr/Uf+D0qBxpnUBp2KNiDEpakUxlLOB9fGmjgrasu
 RebVdR8goabJOAKZyBgvBGYL31HIkgkq6rX1V9xQcwfgRzW/xQA44Jo7iZPJwIEiiXq8VnYAu7c
 kd2E2veG8b6C/jGGw0LUDlVf/V+zqEAICaEIhS63YpjW4Z4rGUMgqQmtJ9geDJTPT7GS0uWLEim
 Cl4fqb8V83d/2TqVpRZMvGHqG2Iv9efHOlKlc5d2KJXWcle+fVNh3v5yFYRxYJzHAwSDeC1lQPT
 0PgpQ8S6bV4kk0+1JnmuBvH8gYBIvWVJXNiUT/eMUw5unf/I95sQoZ7Ukn2SoPIsiDKJyDgkgqd
 x09rk9C1V+Ri8qkZL1g==
X-Authority-Analysis: v=2.4 cv=BNWDalQG c=1 sm=1 tr=0 ts=6a560a07 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=mVMjwrqIa5QPTF8STQQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: mssWNk8Rr_eli-tkUN1Nfe56eAvC_Sey
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNSBTYWx0ZWRfX/RfKrBmgQvNF
 WJwzU3X7eF/P85CuIg34dNpbqjzni8xEL+hcIWj/gRIHh++eSxwTIqb/pxqC0lDaJyhS+qXCpij
 FDoWYKWeXclHO+QjNbL+gWKMIdfIqjM=
X-Proofpoint-GUID: mssWNk8Rr_eli-tkUN1Nfe56eAvC_Sey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140105
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12479-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61B9F753374

Document shikra compatible for the True Random Number Generator.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index 6116289ec413..de323969fe64 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -31,6 +31,7 @@ properties:
               - qcom,sa8255p-trng
               - qcom,sa8775p-trng
               - qcom,sc7280-trng
+              - qcom,shikra-trng
               - qcom,sm8450-trng
               - qcom,sm8550-trng
               - qcom,sm8650-trng

-- 
2.34.1


