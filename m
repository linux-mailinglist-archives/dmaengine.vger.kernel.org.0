Return-Path: <dmaengine+bounces-11325-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9eiCLtu/JmolcQIAu9opvQ
	(envelope-from <dmaengine+bounces-11325-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:12:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9796567C0
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:12:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ToeN8+DL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Xxn8HxqO;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11325-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11325-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E56B3010201
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 13:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92703382C9;
	Mon,  8 Jun 2026 13:10:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA336BCC9
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 13:10:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924254; cv=none; b=V01cdQkPRoxOHnH0hUjiWD6pp3Iz3A9RFYuG+mY1W/ZMWicRUG86DCeFI8U6HwPe7MnykbtfeQGPAsK7XzHJiFjcxaQBHuiwIjYx0nTHGwo8n2IhcxeRxTpcC0kF+pmEFJ1bLiC6q7q5FleuICcgw6gkXbJ34LDqiCuQ0W8wDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924254; c=relaxed/simple;
	bh=9nJ4RWVS4xD358qxJqQ8mIalRRMghPwYWOD3PcvvDzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPZo1ERBwjSYaeO09/FTH2O5/IBR0kXYeazkoEXbGFcfSKWWI5+bWMQpqMTZ5aq/b+nYCj3JpVc6YjmwDyXD7zUFYUVRGN3ZImKQ4/Chn4ecJsdJkog8N7Ss4+601b9V2Hq2aBI7n3+cugI1mg2IxwYcLIjgbfELnJhoJ0KnSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ToeN8+DL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xxn8HxqO; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9Tee2993054
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 13:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=; b=ToeN8+DLKCltdiOf
	QYvKO6TWXiRhb2XgeqvhBwzN2Wmoo+Yk7SL/hHDmlfMdxvV2u1pVTXmFbfbN86ki
	CA0Y0iwGePGa/3lHvIoEGuFhywavLko0EgnRJi1PetEf/DMAb2OpWkTo+kKDCNfM
	/AfsUiD52AYVDDPrsqUfxnk6yp5uENsbQjnv2rD4Sx47ROjtu/9E+w838VdzmAaz
	nhxsUCrPHWd9afG+hPlR9qIwCZtXxsF4ycTPRUUa6qoL+rIVSBMwd6rscXJyKQ48
	02HuCwMaVvJaWL+Z+CfpN/6RVZHNSP5o16l7+jj2zIjAKyB1w6IuqBdXoSWU9zcQ
	OHf1HA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuna8sar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 13:10:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8581f7723aso2553825a12.0
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924252; x=1781529052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=;
        b=Xxn8HxqOTpl7nKV3xK1sK9RpjzPJMOMKZ1FUlrqcc7EciyYPkneXGd2EA1g4os6Fd8
         4mjCl/+WPjS+93cSkCMmtidKW6EY/FwydB4qj5lYtuUTDyGlfp21n7R+saa2O4QXzQTy
         kJ9rvs2XHEQH83UvraYSDPn84fALFW6VHhdBJNJq0qEaf8uXLFQq9zMxQtIoS2osTN9R
         UJNRN5YB0N9ffkCiMKHAxg4HW56cfOWvTXMh3DSWpxsaqZinYbxxuQct/VG+zBBxymOU
         J577LvOPeeVtZxGaisilwjhttbZw7mQnrSg1JUXbod8K6nPY5MWs5sjl9MxUO9/qfuMb
         J5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924252; x=1781529052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=;
        b=o3T++bPUfIAX3/xbCCqD9rzOKf+f5Efi3jq/icPzHg9FdO8YOuZSJ4Sp3uoHwhsfl3
         Y+ee/rcXoheCZ+cWxjdg3v+jLXCZttYTT5Cv+vJztZQ3pN/4H/2BJCChBcc1qhhHn7Vn
         k7oZ8hjXFOftnccH0NWOf2Mb6J2dfpcPn9oYlvojyrzn2WuYmNg8BwdzWDBfeM518Ody
         CindfyKYRuNRm7adyDF989+2kf/b5HW9Lq7YnIM5UJzs+edOd1Vmz7yCHT4PB3OzKEoK
         PDbftXX3yUdfAc1lTBg99jTQ4Tu3jiBIqnUrp+p+tiIIVNGFFkOZSdI1Dc6NTtuz1rko
         PQuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LcKq3nUEn0DanOTvCOT4crU0dXtiso4XeVOVf9AQJQ7hRdjsVnd32saYW7HvsAq9kquxLxPpmwkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyChUn0aL8o2AU1ZI7OOXL+JhCOHAtrMt2b67G1xSFI8pr3B/HM
	0kkinoxMJYHZ1bDLgDxJGeML9ved6uNTYulfCfssPXswU9Grp4aO2lBRvT/Pq68kt5bqt1se0Jf
	T+96Ye3Z424puqkY4VmswN8Sc3hzn1dww1t/AjXdDPttrOLNy1Nr5VB2YIvhoTyk=
X-Gm-Gg: Acq92OGxIWtwdeoFcgpD3JtjmPQmf7JXOduAw3Z9d3ju+5qfZh7/7DUiNA1qhhwXMJ0
	QTZxEFEAbWvczfcF8Tfm8UP1zZOxfuO1rJNHifW7Gz/JSIHwqDxXQmuzPq30OXStbWdp8sWHO7Q
	jlZpY73ncNHaEqe3iO8cfSUiQOz2TKqyLubpJxOpCEuepJ7JC4YoJ1f642uHpJBkMd+j6eHmSZK
	+nunn1121ffN5Qp3LjV/2lncFpf46+41QjhozfQ2Io1nkM7gPTumNU9g2WdTBbc5Xuof13Cx3lk
	eaDbOw8p4l5wEC67sNxWvuCBUb+XpBm1qEAZ9xozOzhq7tpnG8cAXQppVITLJhl73oujEx6N4Jb
	CSb3RKByNMnbyq8PoftomGFNIyJ9NMfEHuc8Rt7m7qUtDuJ8=
X-Received: by 2002:a17:902:f606:b0:2bf:9760:b963 with SMTP id d9443c01a7336-2c1e810e153mr176407955ad.26.1780924251950;
        Mon, 08 Jun 2026 06:10:51 -0700 (PDT)
X-Received: by 2002:a17:902:f606:b0:2bf:9760:b963 with SMTP id d9443c01a7336-2c1e810e153mr176407605ad.26.1780924251482;
        Mon, 08 Jun 2026 06:10:51 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:10:51 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:22 +0530
Subject: [PATCH v4 02/10] dt-bindings: interconnect: qcom-bwmon: Add Shikra
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-2-2114300594a6@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=1132;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Ie2wM60+tAThpQPFlruvov7NzPvO75/SEoFhbJfHGt4=;
 b=tNkS0s8Bu4a5n5l/WlkzXwkGjZxfxwWSDn+0OvPTRAaen3Spmk3CD/7q+v/+CPsg4O/e9t2jk
 hXG9g5vRbKrC6qR9FtrD95X6awPWXaSBT3PBCEd5nCvjLnhQCqswj7n
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX+Tx1e71AXmEH
 m/DJ8yAqdFSFSpcoyp2UZ7E8tXNz8O9yReLteIkB3tK3eChod/OMW5hSLMxFvI07LNvM4GsANnp
 N3reLTjAdsCiJWCM+loJeAzBW91xG1LJaJT8mbtDzJTKxSa2o+xqeKY1+v/XuabOVYeXxoAht00
 ZJ9tJ8D9dtT2TNz73DtxPqLQTglgIFFzg8WJCJj4PVtSp30UIiBBTvjo1DrlgOIxGbvrJS7OSZu
 /NPS3PGtqdoa5VqbO+lDbNnhaNQheUtTwVARBtayWlzmYimHRpE16GijjLGKMAm/duc5UHopwcx
 pGb87PM0gNL0TYSFmWY9VOuBUVPfqwKZBx4iyl6uq6g3IyYsi1qs4ChtUz9qrFTWqCYDmWDn9sj
 UhiAUjl6MhTe/V8IpWeZAKcx7DGRaKZM60WK3BbD4/CmpdIlbBHkc5dAFPO84vk7Rt3r3L+j1le
 IEpeOrF/kIdolIMPWYA==
X-Authority-Analysis: v=2.4 cv=RfugzVtv c=1 sm=1 tr=0 ts=6a26bf5c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=s2Q_muabT7T23weRVv8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: YK59QyO2SepMxkailTPIY4Ft7ezpSsN-
X-Proofpoint-GUID: YK59QyO2SepMxkailTPIY4Ft7ezpSsN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080124
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11325-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:sayantan.chakraborty@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB9796567C0

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add the Qualcomm Shikra SoC compatible string for the CPU-to-DDR
bandwidth monitor. Shikra has a BWMONv5 for CPU.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index ff64225e8281..8f6c937e44ce 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -52,6 +52,7 @@ properties:
               - qcom,sa8775p-llcc-bwmon
               - qcom,sc7180-llcc-bwmon
               - qcom,sc8280xp-llcc-bwmon
+              - qcom,shikra-cpu-bwmon
               - qcom,sm6350-cpu-bwmon
               - qcom,sm8250-llcc-bwmon
               - qcom,sm8550-llcc-bwmon

-- 
2.34.1


