Return-Path: <dmaengine+bounces-11946-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ANfFIJY5RmqjMAsAu9opvQ
	(envelope-from <dmaengine+bounces-11946-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:12:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8CC6F5B10
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=SU58JKpZ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=P4TAIKDU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11946-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11946-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4A81336D013
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7157A480DE6;
	Thu,  2 Jul 2026 09:51:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19941480DFC
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 09:51:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985863; cv=none; b=u6zFKKwk8W0hJL+Herebvbub7rZ/plvB7nub+irv6+kzvXNhQYRoKWiX+5+0quyRJ04/0/t746Pm6QFNehHk9FCWf0Z8umIp8/pbbsHKrXwYpVxC5aFaqTcQZ1T/23q+kBOy6X+SZ8xQ3XIOD15Ep3YUB3IEkg2zm1PSY094kzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985863; c=relaxed/simple;
	bh=9nJ4RWVS4xD358qxJqQ8mIalRRMghPwYWOD3PcvvDzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfOGpVhgQ7VwPmZNx+hIKwrwkpN8paJ/sqtIJPlm/b2NEuai89J2FsmQwqHQwEAXK7Pqm/O2noqW2lbbXk8bPelMHxODXMQt9OYW+V1K420sAI4irc2Rdr7XXEurzKv7PRKy7TB74BqiOAl0R0OGgD23x9RG/jB29B6QZyKOzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SU58JKpZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P4TAIKDU; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628n3Xh3046377
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 09:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=; b=SU58JKpZQ1TjwFrn
	4MSRJTjLcePUGT6AUoeKIzdQrUEvnAJXDd7F3ryH+xEBPSxxRPpA0xtXsSrYsJNX
	4n21fNyCVtfmpUzZVNZsJHqY7O2d7BB085k14JZQkNH74+P5dubFlYJBBVQgmbda
	VYl50ymI6+a061XPPp7VVcWyN3LW4KUPs0aPCl5f2G28WiLdSvs0pI68kpCllgGd
	hK8Wa6Azb/v8gxN8+QZGWZ/k4rWfsGRi1+0rh/qMUpVNVZxOohs82UWkaxKHi1k9
	1GZbW9p/DxJzw7FwyokH8HwU6iNC/6sb11kZM3dAtXAS5q1EbW8NmeU9ZlujX9RF
	AvRKaQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f58k3aw9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 09:51:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-847a483ea41so735257b3a.0
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985860; x=1783590660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=;
        b=P4TAIKDU6wwojf5cQ3AoqAZYNm/zFU4rawhykzLBgxElve5yARnHdj6ID0QSVeLqBx
         HDrefc4bD7K9LNGmSrTDqykWADEpwADwcoyoMgI6xfVFQyK/K1Us/40MB2CCF0vakeSj
         U8ZULWuONkgL51TC9EpOwXRTDXTJp8/Abg9FhIF9gcspxHOVxwfFGi39nVg8fhXX8NaL
         eu0fohNc0dx+po78m692Tk5v6s+W2ViIC8ivKgfIWURGfUEZMRb0bJhckh/LZqWpEYVw
         xTi+6XNXMqwsVO2rqJ6AITC6wWik+huTjYgA/W+c1S+KB9JIuhNnOfJibvFeC7fgipmN
         VlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985860; x=1783590660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=;
        b=d3uLbDbSilu/4U4OeC7nsCjbGyEGuVPJKViyAvVYHFxR2n7idd3RGhoiDFBaI4+dO9
         dJFIG/323vdCtFBym3BKYW82sCWVpQPXlpoOrgyqoHcYCIOYBiyh4P7R+qg6kFfGkSXY
         fItQleVtJVQ3MD7gsYX1oTtuHFo5a/mLd8NUkygp+E6Ivbs3D/nWG1XJTRwKJKIC0wK9
         Lytg8iXHvXjGPzXXb1ksLrf+ARwn8dJpDa1d/aCEoTPHvPcCD98GNDgyvCAD7CulqCDR
         VuRRXHN4bjjfM1uP1ML5K3oxg+frLMdTft/gknZxi4mRhdp6uSnthoBK5C/CrGURXbao
         fOlw==
X-Forwarded-Encrypted: i=1; AHgh+Rpfosd9TLYWhzDnTbDiqRgCCquSlt4A5IGz4VSKYiho43+tYGweBoQLk0D+f6cxcxDr0v13G15B2x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm25Vi3ekvDtwk03SLyAWrjLKqs3jqq6agyyUkGKw+zZ6b9jnq
	m2SNTV9aqxUNIUgwERKU3HzxIgnHT/CNqWLQ3LbfDrX/xaad346piXKDu4WFr7IXkO4dNjcXrbm
	ggt1sleqWRN7CSkjgBMT2yKZWa/eo9sexNvo0+cOhynE1VOKtr1yhspizOIlxEZ4=
X-Gm-Gg: AfdE7cmYNisk330X/uV+7ZFYjhR5uHUUvhoYJD9l8hYalE/EVfLWqjp+tv3js4VRG/T
	wlapXuLxd7dyeBZ4AMsejkow4IQrV9TLH7mWZAF+OeISOze+8y4I4ps66jva02hcLjqS7g29fkS
	NLUalHUsq7f2FqOeXvolyh29HkaR+i2ahcNWlxbNgJE19oCoRtNz5Tg6tg2LeU2hcyHhOE6iFZj
	mo8+25GP/s1Jht19YOuLyrRBH4v+5Jnw/m3P3nrV9lEX5hxwLLBd6PZbXMOJ05qVZSYMpuOSexU
	iiOszfy1YjrJ8toPy6KRa82MG9TKbs/BxugKaD865tdX1PSGy+6UwdQJFBwxvInG0nRrrWLRZmT
	XYyOu8xliyvz/1gZwiSlGyAPZgg==
X-Received: by 2002:a05:6a00:2e18:b0:847:8704:1c57 with SMTP id d2e1a72fcca58-847bfaa89aemr4615523b3a.31.1782985859787;
        Thu, 02 Jul 2026 02:50:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e18:b0:847:8704:1c57 with SMTP id d2e1a72fcca58-847bfaa89aemr4615487b3a.31.1782985859351;
        Thu, 02 Jul 2026 02:50:59 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:50:59 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:43 +0530
Subject: [PATCH v5 01/11] dt-bindings: interconnect: qcom-bwmon: Add Shikra
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-1-f911ac92720c@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=1132;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Ie2wM60+tAThpQPFlruvov7NzPvO75/SEoFhbJfHGt4=;
 b=ZIP1YiQcXGJE7g4pWoGmEXtb3ewqdC70YHVWz4xY5O6bKf8/cGA0aXgvVCmfw/GSOvWdwZmDR
 qnvxbdh6KvUBh6CgpQnPLnXZMjWULORJiFdySKPDwY1W465wv0Hyjhv
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX00jZBEwOewH6
 PMcAvpiUYCDB79YmyI64zbVPlsJ1z9qOny5R6QZU02VSvXxdh4OTf0xg1Hi/qk6P//ThsbPSbE/
 fLP4NMRFsLdFGOfwWZBR8j6rbmb0s9flZz8d4xPmZG40wu+0kgc2hsjrDcuSGViMuotRS13JyDn
 MN4F173/Dv1AWChbCTaWTdO04TFOAO1cJuRJRqEtyB7i5oxH9RaBUJkj9xb29i6NdR2nDWxliXh
 eM6k6SeWybqkKsZ17/NDIAeK3EFc4IsdhDfE79B3F7t236TMC/aFmk0bAA4DUF0jdQoGgc1y/qa
 ghULuap2pK0P3zBeqExwMaNM3aOTXnVAAUon01p8mePCcPZatBuY2tQporSz2EvhrGtxG68mi9x
 b7Uk3ASEsivln9QeVoDHEfI64LBF0RWadDaxko6d8/IwEMZtBnp2WTylA15qiGdaM8MbfH32j7O
 luWgYzVI21uF7ameAPA==
X-Authority-Analysis: v=2.4 cv=SuGgLvO0 c=1 sm=1 tr=0 ts=6a463485 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=s2Q_muabT7T23weRVv8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXx2wnqU54CQCd
 MlQLCUtGgj6/1KWtYYOfeScmzXeQOu4hRRrdGSo89fPhkzPt5T+gQVu8MfW3lPy3uUQLTV3WEpC
 DhSU9Z3g5w447jponKDKKuJJ16JyVV4=
X-Proofpoint-ORIG-GUID: WCaj1OIykh10k3-oAgheOfJ7IWxA65wx
X-Proofpoint-GUID: WCaj1OIykh10k3-oAgheOfJ7IWxA65wx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11946-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:sayantan.chakraborty@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F8CC6F5B10

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


