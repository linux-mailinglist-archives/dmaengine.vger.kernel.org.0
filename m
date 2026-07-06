Return-Path: <dmaengine+bounces-12047-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pf3eMBeTS2ohVwEAu9opvQ
	(envelope-from <dmaengine+bounces-12047-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 13:35:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D6770FE89
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 13:35:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="k/0wiCVA";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=GWASbcgT;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12047-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12047-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9D133023122
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 11:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3965D422520;
	Mon,  6 Jul 2026 11:32:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82E35AC24
	for <dmaengine@vger.kernel.org>; Mon,  6 Jul 2026 11:32:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337547; cv=none; b=jwaPBKPXDFTDJfJ/hr8KolIluXX5HUB1jeBADi2S49EIEnLwOSf9jjJGjb9qy4HZdjHEIx1LIILWV4HGrzA6WA5mTYKywOrTw9X6B3HNiJZxWRV2c4q0+Si0VUWcmyNZURIi2AwdZ0QeQU814AFXRecFAjPIRK+kBp7hXQw6blY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337547; c=relaxed/simple;
	bh=1pydzzpuEgb99srFhSDcm9R9pFLKSlB5QaWbAzMzsLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVwgWBDj/8S4QJQTYBTS/X/A3KubsGzAG4xZ+4xVB+gHOs+Qq19x6gvAS0G7IVHs/oC/8KqzT/mSqrF3BqoosBVs0gfB8D+PTuNd6FOJSX2yaUOXDG84WUjYJZf/ocVGtyaZ3CO6IE9NXOcdwp2tZ1Jf9vVfecy2u+yBJ80Z3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k/0wiCVA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GWASbcgT; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxDQf238262
	for <dmaengine@vger.kernel.org>; Mon, 6 Jul 2026 11:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6TsjOFxinHMTdktlzXIAquk5+1TYhiyxBMyPgakzTtU=; b=k/0wiCVAxdc0lvmY
	AGxukyenVES+/EL/HdcZgGTRO1AxXjMyW1i6e72AJxhmGpx6vVwCMxyCBQD3tCSX
	MJP0/Z1xXwVUN0ddLQkuAJS7fqQS1r+aVrJ0tryEYgH0iCYNX6KnNdWht0CWdyu3
	JSL55dSaFtvBioX18YENlyF0MCR4G/kDj+hIrFJgUtPgTcJMLsH2+m1nIHOy+WHQ
	NeXrnnf00q32PMAIV7IFbmP0ALBSogjK6uMkL90MabD+/vG2JZV28IrPHmAmJuWe
	Q9M2aKcpHaFKus5eD8cocap0TgtWz0elN6nYIX1eAWgrKo5QER9vmzWre9cWnqPA
	ik4TLA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t88qtw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 11:32:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so4108629a12.2
        for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 04:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783337545; x=1783942345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6TsjOFxinHMTdktlzXIAquk5+1TYhiyxBMyPgakzTtU=;
        b=GWASbcgTFl2E7Xx/6K9iH+taMmNk608gVb4dQRfM5cJQ3/j/8R8/TsKzxQs83JuUT8
         E27hlQcujVrBzl8llU4k82jivhLRil7Rx0kqtltsQQ+C+8y81FvzknOq74QLkekVONtO
         LF1IuMDsPQAf0svoYf+xiIpsaeZVJAdubzzXCZ8Nwo7JbvW+SWRiELMUHXNECvCEeRHI
         0KA9N3tbJpgnT55tC98vWkTy7/7bgz2nOemI4b0ne7430fgMPyo9B442iw38JQQu8sAl
         QtL1xKnuwArmh8lw54qiWkuA0z1yHZgH6ooCIf7hoSXZ77yoeb+8+B0O//AtEv3hZRt7
         n/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337545; x=1783942345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6TsjOFxinHMTdktlzXIAquk5+1TYhiyxBMyPgakzTtU=;
        b=OF1J98tjyaePTNkAFHW7k7F1gqspR82LwFG0WWOwKgWZ2mBTPzSPiD0+vPJtjaBHQu
         shKyzrfXAAXgAePMqdvk1nWU32CQh4xQHAQN/cAnmW1zDpkcdT2BluIYNWER+kCG1YUA
         31KYhgUDPtsekk9rBNaYTCCHLWy4i/ZYIjmlBonec1yrdOAJICIMoiC/qCM+6LBlVaF+
         Raj5NIjXaW63Y4l9rCBH3PNf5KwwpEdfHRvPIjWrv8JALLNrhR3RFsXBFmfPF3+hlMP0
         6FcMkPnIXgbsyeD4VcaWc5c5VrnVBD8v9KPwiMaOe6fY6GS4NrPlarkrWTu49MQMBTvN
         N7Vw==
X-Forwarded-Encrypted: i=1; AHgh+Rp82AQk0U6HoGA+awGpaD2dYXH/VlkEro/5TQeNDpB3hmaVfHjf7kVXp/5scku6d42d9nWDJTlmxqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNxG4pNXdpGz5cMJHgP1mrJVIBXoLtXss2Lu9M4056xso4+kv
	Y/5X1XmhP/om3ZLwUrEp9Wqx6hkLWAaIewSQVTvhT9YjqFOfGQExP6GfiGoW8TSCL+GK6iGUpgz
	p3Oh3xHNYBu0KhEfxpi/Ig1abmbXb7qtcYuXq0CJDTATbnxKxklT1xp/z1d4VmP4=
X-Gm-Gg: AfdE7clW9OqcBkSre5DZ4/nhtKm8ciVw75kJQfZ8jK79T0OQgNwRaJIU+b2v4UrVJTo
	twaJNA5UPNFkLiyTtRViwXq/0nSSxtPJGJcdu1j6voxEXpuMLa1NbXtAvL+jKsj+CdTe3tNaO1o
	COQI9+mTN7Gqi3ZSN5Ob4CqYC/5pcSbrI61/+oO/ryHr9YyKVr2WNFWd2zCnDM7grYbBw8u9Pqv
	/SJKH7u9XqTaaFi9ClXfBx8V5/3PFQZJ5M/AQp06jkImbogdongkZz4R2Suk5gV4/+mM2Oqrhnu
	qHcI4eJo1TZQb7pfAwSgB3jyBSsn7LYPNwk+1QUNSp5g1Xix09o2KOuGMxdgtvRDzsd5u6bQp08
	fWeZGygGmT5lKy4vr3MkYgJy4Xc2Bfb4See6VUeoB0YDH
X-Received: by 2002:a05:6a00:4501:b0:847:84b9:f3e2 with SMTP id d2e1a72fcca58-84826f0df14mr86405b3a.50.1783337544588;
        Mon, 06 Jul 2026 04:32:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:4501:b0:847:84b9:f3e2 with SMTP id d2e1a72fcca58-84826f0df14mr86360b3a.50.1783337543972;
        Mon, 06 Jul 2026 04:32:23 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbdc8dsm3576621b3a.55.2026.07.06.04.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:32:23 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 17:01:31 +0530
Subject: [PATCH v3 3/6] dt-bindings: crypto: qcom,prng: Document Shikra
 TRNG
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-shikra_crypto_changse-v3-3-23b4c2054227@oss.qualcomm.com>
References: <20260706-b4-shikra_crypto_changse-v3-0-23b4c2054227@oss.qualcomm.com>
In-Reply-To: <20260706-b4-shikra_crypto_changse-v3-0-23b4c2054227@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfX978PQ6I1ldOM
 lgfVf7+Wr4uplX4ITf0+3aopCHDZpP2WrbIRL/9iqY54HSyb4RIr32Wy/k47acb+9TkChYFcDS7
 oTZysmBNT7KVCd3kjNYhkqhO3iKz2oQ=
X-Proofpoint-GUID: P-KEZ_Il0PHUm5WhhylRHJ1T_rzRJZDD
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4b9249 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=mVMjwrqIa5QPTF8STQQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: P-KEZ_Il0PHUm5WhhylRHJ1T_rzRJZDD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExNiBTYWx0ZWRfXzMYy+YRUqyNc
 bZzLoya419Pjh37VOXUxHpHgadLBm6s7Nw8scl6a1282bFsqL4Zzq3sr6OnIebSi/e7RxSj/3de
 h2mf5zalFbZQnpXroGEMq7lVHQ2ZK4iUIrK7tk80ky2gDk4VEtrQgJtriwegbHv6KKyDWphmivS
 8CJ9DDzf+/LksidPbzdKvnWNmd7Ei+6MbKevHFlfkqesv2+oE7FcQ5IegpBh/RmzPGxZEf8Yqts
 W6aQMBWNEuxu1VIKdDxmi0DlXVolDQP3PQBfjyUnlCZBqAJMRylUz5wmrrxrZ+dsDpdENy0ChXj
 sS/g2ipxQAJGEflD6XZd9vlm9lLoRmtRzW1akyGluruK86ZWg/O4Xg+V/vL7xlznwsRkGiVn7BJ
 /HTHdl8bzY6922bpKhOOLMN9HFt53SIb7KNsh4jCJKtfit6aCIbhhredy8M4lc4EEogITmvwAwn
 h2wf7sznEmcrL/dV3Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12047-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: B0D6770FE89

Document shikra compatible for the True Random Number Generator.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
index dc270c8aedf3..5de52d7a745c 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
@@ -30,6 +30,7 @@ properties:
               - qcom,sa8255p-trng
               - qcom,sa8775p-trng
               - qcom,sc7280-trng
+              - qcom,shikra-trng
               - qcom,sm8450-trng
               - qcom,sm8550-trng
               - qcom,sm8650-trng

-- 
2.34.1


