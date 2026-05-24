Return-Path: <dmaengine+bounces-10784-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO9XDmxWE2oT+wYAu9opvQ
	(envelope-from <dmaengine+bounces-10784-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:50:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A012F5C3E2D
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0EAF3013A71
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 19:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744F830E0F5;
	Sun, 24 May 2026 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qldi2ZGT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VTrKB+mW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3A1CD1E4
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652180; cv=none; b=Cfc7jL8f2AcjwwS/e4dK25wMXnTUcXthW7krmTyJyH12JrkO2WtGdlAgXTopyIWH1FLOXXvX8lm9uPgvHyRGDkDt13vWU7DHo74d7CauwciFTKH3KvehhLAYWlLTf2WhM1ZSFjz7Q3sYLXQkZSGL9wO/5RxWO4e9MkMa2DPgDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652180; c=relaxed/simple;
	bh=xt8fdY5E19585IRxlf2tv2dOaGtOy/UcGSJMOtFMvaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUw7jrDweSAoFnmLRaSI+y9ZKbf/+FRZwqQEWTLu3EGO1osOsZatWU0mzr48X2MaADZsS8fH8YlYL6HFgyJs5+56qcfZu8K6N8+JlEuLY4BjVwv3EvQ47dMkEEbyw28wKG2ZHEx1upG27s3QcMaAWlFuGn1VFokDb12OQJBUkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qldi2ZGT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VTrKB+mW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O6GWiJ930452
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=; b=Qldi2ZGT1tzOY/PB
	yxsmbJyWtPfWNTz5HQff8DhOsrcyM+7945g1GDtpZWB/sIvb/ZpljzF0LnyehR1l
	Mx2FJFpfHCZmlxaZiSitl5p2/obW4W5RllFTO0HZWIZdcvG98dPKbbcvhcKhdp/r
	p1GPQr8M1hCw7JkZm/Lxy4ToL0sgWR/qX3UizZZUkNptbs0cIsVfVt68DssgiRrS
	WWIgrRv5UQzEpybuCSjZikeZ3ICOsHUn2u6Y/ydvJCUpuebtZb8uhY6QDFOvJ8cw
	Kp4ehgXt6a9DoOmbfqeasu5vtjLw0fJ13ptWAHaEuEmeOeRLcFYNai/Iu6qkZM1D
	LewO/Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb50fut2k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:49:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36629e48023so8365416a91.2
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652177; x=1780256977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=;
        b=VTrKB+mW00QQ4vSW//KqhHRuzsrB62VLyyHWKHWac3shCYolXx83Mc1mmP4A0wAqkf
         rzthK4eDinihsp35b5WffqPLQ4jbmpE92BPX+F1eD2VM1PVkn7cznKp7AtZrIqlGOCgx
         G5vOi/sMVzQiP5ibrvYxJFntChYgquj/j6ScREVyxFT8teRhJspyrYVXNOnhUMIYep3F
         PdA4FsgZATgDKWZM10vmIfOVYFzMFQyC+D4iMGm+ppO2RHA5M5hnu9xst8sFde/XqN0e
         wOrTMagG14rYv/c06x+X0u953vESmOH0+GViVgIgshZfGHSeGA/EIk9VaX6zdwtvzKz1
         75Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652177; x=1780256977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=;
        b=qwy8MfEwaHQxYxfEwe2MAcsYfDCzXb+hWyk3wqKPSgvvdIh5RRtn1wOV8qkFcLYe8G
         lZteAZ0BowvvTSrZYSvcYkeQGIxm9n+TVftbOJX/wSDYyJVwlX8H013UjJQpBLkGFvRr
         zckLH0zpRB1DND0o6xRC1uRXLhBDj6pu7MUDvt6urnmJdd7NCVsqoekGO1hAk81L3pLT
         JowKT242axNCYHOLKHIlZx/b19EP6FP3D+MBDf+mXNLqKRthSuxsqPxbSkPWvTQ46OBO
         3U3bJK+YUfOomNGH5bmpSGuT1PHQLl4giyr8/29zfw17pPIW2vpJqM0y9NB3tw1IHqke
         yRVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EyX0IAYjiSYb3AgWvgSixxDY4w1X96aXK0t/s+PnULrolX93Li6tdK8XkTfIR4mDizEgfesutveI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKVSEhT0fh+Y5kOS0gF3eo3ufUR6A8qvjNV1bkJw9KSY9yLhhl
	wPTs3AtYGXVqMDeec2tRwxpWcmEOzGf2AQ66jqd4X9EfXaKAJ03b0jANgWjwNIsNk6v67Yzt35p
	75K66eLn96gv2tfNAA+FummiWSQX/eGLMHyJRWDhrXR0x0C0egSHfG+AMrp7e974=
X-Gm-Gg: Acq92OEjFykGPdpTF/Y/ja4JSIBzoShXj+iU9hR5QYpEIn4xunpK2cTYhXxF6P+Y8/G
	as9pR2Qg7Tj3VlQOiQyWsItMURmWXv4jEa0RRmaMqTw4//RhcWTSEx/jee/8bJQYyzovP/pxkto
	FUzR08g6Ie5Jhy529Wl6dK6B5WRadVw4KPgs6qkghl/UO/CkmSNfHKcTVj2pmcdrR3RlubNK1ii
	YDrAXLkOZ2mO9BXMQjlpzDfSLk7sEdLatHYFgSVwEBGbYjJKMew4QYeOn0nSZ5NiPP+XI1oGpJr
	TON86bqAwRj8O3xT2SFejtPWf8bwduOglwxEIAqzC6fnwjCFc5mmko3fjCLTSWr4RtZzvBS9oo+
	sWw/pZYdOt7QEwDHLoJKFOSaPeDCp6Ioki5i1
X-Received: by 2002:a17:90b:4c87:b0:369:7421:b376 with SMTP id 98e67ed59e1d1-36a6762542emr11236355a91.19.1779652177372;
        Sun, 24 May 2026 12:49:37 -0700 (PDT)
X-Received: by 2002:a17:90b:4c87:b0:369:7421:b376 with SMTP id 98e67ed59e1d1-36a6762542emr11236340a91.19.1779652176837;
        Sun, 24 May 2026 12:49:36 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:49:36 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:06 +0530
Subject: [PATCH 02/16] dt-bindings: interconnect: qcom-bwmon: Add Shikra
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-2-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=1062;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=MfVD9NAJt+YvcfkJInifeQ/jWKYZMhdr3T/JUeWSDbk=;
 b=29RL4I7Ux9+C57dyAQnhNhFTDoo4eCONKIcb+Dm+cyWsxoYC8iISBS1CA1Yg86kt9nuCErdyM
 u6duK4QOoKHC+Qksbo0V8tjo0h8UF6NIh20Wpemx3XoZQ9tLQH/r9RF
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXxbsPN482mp4O
 wEPhPvoMJuRH9UTILC2Z/jEMrLbZJEPqZHW+cXaTgSn9xYqdhEnFb8T9f1RGYuLyO/lV4JdbKLY
 AgOEPUuu8kqNXDOtzGqhKsEn4xM01oXo0nzZdMU8b4wgsaEZqztW9WvAchOVnQnIotvP26EVVkc
 88KUrgkvyVNRc1QIVRVDPRe4ztwU7Uv9VippLTrXf0OHQAddG2VozCkLGZydAId/P9yNqsCp07m
 74YJsaYWtcOBT2ofK3vzOYBO8lIL8u91JFdd2VU2aB94vUWyA+J1ps+DN+0nzbyyEYV8qGWreeN
 HrlcPYzqM6IQrUBhY8tO87cmnitTaghZH7ZZERRqZo4q0aUN/A78FfH+L5qdH48fHBKefrhtWnK
 NVlVHa1KtzPOBgnjr591Msk6PpJpuZjhVNh1OhzL5hwV0GLg42QbU5LrHOfvPWWV9mOM64HI6vc
 33EWsZDNr46yWmZlFrw==
X-Proofpoint-ORIG-GUID: LP8hnIyy6xpN3ev9ZEb--8Wnx7oWD3kh
X-Authority-Analysis: v=2.4 cv=UdBhjqSN c=1 sm=1 tr=0 ts=6a135652 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=s2Q_muabT7T23weRVv8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: LP8hnIyy6xpN3ev9ZEb--8Wnx7oWD3kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-10784-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A012F5C3E2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add the Qualcomm Shikra SoC compatible string for the CPU-to-DDR
bandwidth monitor. Shikra has a BWMONv5 for CPU.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
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


