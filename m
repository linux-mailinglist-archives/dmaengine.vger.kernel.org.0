Return-Path: <dmaengine+bounces-12455-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wq/WLuLCVWo+sgAAu9opvQ
	(envelope-from <dmaengine+bounces-12455-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:02:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 513DA750FF4
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:02:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=XyadkByv;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Xe0A06pG;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12455-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12455-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59D4C305330E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 05:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AD81D555;
	Tue, 14 Jul 2026 05:01:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4F2D73A1
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 05:01:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005289; cv=none; b=uGMgHRFgH0ttx6X+uMQwSJBZ/Q/yuNLWlRuWXSGi6U2H1fGbzQUQpsZ5/CQDeZ/I3Jgf8fbUI/vFgDW31wRDyu66XKpAiyG+Oe+pmQjY/YfUt+lOAnln+omDQ7hTZcp+AbSIBCXX2WAnjZM2aarLERMODVvNPr4G5NqZNkFCKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005289; c=relaxed/simple;
	bh=x7LdWwLo0cnnNjSUljN9XXvIzCWAYsE5+JIPg54yzQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVzbaVh3qtQqUQNNePX/WBfgLeHuMo6xibNjgdhh910/BvmkbRKfp7Xr1kdC6bklxH3MPC+SJIyR1siIuCJ0H2pBWq4e45oIH2POFP2HTzlmA4ChZdWasCt1mLNvZuQyx5u0VF2qG4mgUq/Xs0Uqe+IWisgZzAzfrDbVEh08wN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XyadkByv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xe0A06pG; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E3823U3556545
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 05:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f3zDj5t4nnjFf1RljgE9ae+K/Mz+sZ+dAu7FstVntxA=; b=XyadkByvVLCGWmE+
	Zc3hOkF0lnbv3F3Weqs0B7IqBtDyT7b5gOZo9BDXc8kbMe8RZlokDJhZrHkh2Q1r
	joyVA4ACBNCPqMgqcx+Nv3KVZWzyfUyMEtfg8QbceVahDddTMeuph7B5SN0Eh05F
	YQIiS/29Pz803k9SCvadKbUz8Zwh6Xg8Syzk2yeaWaOAUNTGTuktSsxmxBIBgrcV
	kPLQ6MWfGNvK2QfdoE/DzF+PUXdmfvYPXyLGOqT/mI5hsHwe2Cc+67CanjmeIpEg
	RtA+P8hzOH5v7D6yjdjXHSuVcRbhqlyRS70ZJIC7bWdZ2FRg+jSGUope632psuWj
	SdDxZg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44ct1fn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 05:01:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84877b362f6so6524877b3a.2
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 22:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784005287; x=1784610087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f3zDj5t4nnjFf1RljgE9ae+K/Mz+sZ+dAu7FstVntxA=;
        b=Xe0A06pGh+gOHTXgMtgjgC1oaqUoJ/LT1h+rybNVNKDWDO6fdXrAcq7ivXqL76NwgJ
         NZBu4CcX7tobXcQdPLQM9IUqbLC/SEjRUTOrhkrEDzOp2De0IJC9LqIRhBJyiPjXaC5h
         JWxzMXvnARXc8EzRqAR68axaiNzot5LyHLyXXQ1FVvAikmqgBqSuwU3/Woxp/ZfJX3kJ
         UOEqXQ0rNpAIXgfq/BFidociGeb167N/vSLjEJdnXRRGT2hBzIZbRQSU/MyPV9eFXvGO
         Mn6ic973cv95+IZwxwSZc/9DJYPBqeiyssKd1nAKN1exqw2C3n3EgdmDFazutx9317A3
         m97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784005287; x=1784610087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f3zDj5t4nnjFf1RljgE9ae+K/Mz+sZ+dAu7FstVntxA=;
        b=qnEQhpjhMWAw7XqZ8dLT4l0QNofk6i9qxo3eM6rfwXvxzK4Zp/PnCoIJAxa9E4R3xd
         eF7IL4zRtOsprFirEPECvVhfkmtVRoVpVtoAK4vWsp2wny2z01In5iBJx+ibQtHQhgAS
         kodxVAMYhK2HQM+a2/a+N4S6JEq4pERFT9hEg61/RNK+AiYCRTKYChwaBYWH0kaW4O5I
         WzZ7I9jPb7tTto85up3iqptx/CHbbiVlh6/gdHDVyGnD4tLfGCur1s5gt73TqyR4+off
         T0XwHkAmzKs7jXufl6T5bQx2koZ4t+Q1CyqxHwvvaUNsFLnisQ9Qvh2suzfnUV1jPD/z
         Hjdg==
X-Forwarded-Encrypted: i=1; AHgh+RoqAYSc40XDxGY9V7NQTOL85JlIbZKU9oEzCb1akcyIMjJuv3Xm8g0LghmZEPL+d8WR2zY8pa8HuQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbLPR38G6b49jXYeH+MDlDbANrK2NcMC08SwMHo5TKns/xdDw
	atd2O/5Rzx5gDcISGA+7kzQhmZPK8BwIouYdZZMvzJ00u+ts1OtoQdhNJTxRMV1N3JlcdQ1sVe5
	E5hvBWwqFQSpfkdxIk6CKWl5ydTX816W0ABmmNr4cagklx3iKDOJEFkFl3x4VDYY=
X-Gm-Gg: AfdE7cn7Rb5rp1s6Yh/4mpT1FGRNn6C3IfllmomXkLeL7Ycysu1WX3ZMmdBCeCeR4Ro
	+ijo/VjcPhqIA2zyc9rG28gp/KyIP9u5tJZfqekVvuhuYICEipolt3GHDsPSPYlgij8ajh8i6kA
	Ef0zs/KumY5a++YGowwk6mHANr//nJDC9r31bzaT8aZmMOnivKiByJFcgRkUH+WyYzwQPJKzPc9
	lF/cvtHlv5kUMeSSnUTC5U56yH5QZ98MFwdrhQAYlVON1+N0ITCVRhpkFueRPs8/PdBY4GvwnPB
	pzBo6KiLEYr2qw5vdETfi5kTjEAbRHUmswBhpzDmsnZ+BeF1+XGYKyZToyTsJO6It4u0P2cmoZB
	17zgxCxLEI3J4krDUZnb/y0IMg/0zYYeRFzvTig9BwUF1Nvk=
X-Received: by 2002:a05:6a21:7a9b:b0:3bf:64cd:c45e with SMTP id adf61e73a8af0-3c35731bd15mr1026733637.4.1784005287232;
        Mon, 13 Jul 2026 22:01:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a9b:b0:3bf:64cd:c45e with SMTP id adf61e73a8af0-3c35731bd15mr1026688637.4.1784005286755;
        Mon, 13 Jul 2026 22:01:26 -0700 (PDT)
Received: from hu-vishsant-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3c1f77fsm9327406a12.32.2026.07.13.22.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 22:01:26 -0700 (PDT)
From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 10:30:22 +0530
Subject: [PATCH 1/2] dt-bindings: dma: qcom,bam-dma: Add optional qcom,vmid
 property
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-qcom-bam-dma-vmid-ext-v1-1-cef87c57b7dc@oss.qualcomm.com>
References: <20260714-qcom-bam-dma-vmid-ext-v1-0-cef87c57b7dc@oss.qualcomm.com>
In-Reply-To: <20260714-qcom-bam-dma-vmid-ext-v1-0-cef87c57b7dc@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        chris.lew@oss.qualcomm.com,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784005277; l=2743;
 i=vishnu.santhosh@oss.qualcomm.com; s=20251203; h=from:subject:message-id;
 bh=x7LdWwLo0cnnNjSUljN9XXvIzCWAYsE5+JIPg54yzQs=;
 b=MOrq10271hFCcD2c2QHE22b+uYCAGDpM3IuW4gFA/UK4wu2vcTXPqSkRTQ3cACXbFdhB2DtcV
 Rin2jnK8mTcAbcyQPlLiDDKYwK+qleXmlTw79bxOhiKsi0PALhvIMnL
X-Developer-Key: i=vishnu.santhosh@oss.qualcomm.com; a=ed25519;
 pk=G8/AJPecB1feGI7wxArGWGN0PPGQS0GUaD4THQCbdis=
X-Proofpoint-GUID: tK5Nkzs_yvvjE-PHtpCN25f9vMBOwT6D
X-Proofpoint-ORIG-GUID: tK5Nkzs_yvvjE-PHtpCN25f9vMBOwT6D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfX1StWdnaf5DQP
 hRk+daWg+WqPmd5f2miZ72bopuwIdQrlVKrXE+e0m4wCUtPXuwk7GCctoNo6f+kDfVlNFsjXH+X
 65Q7XtPv5N0uF9NO+CHbLkv+Y+enBSY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA0NyBTYWx0ZWRfXwoFizTkDrbfZ
 aNXnCATnwzebX6QJac4habgcPKzq0bpoUCaZDP2ieEekmkDulzEuhezkuDARbD7WU0EKQxdfnXe
 STP4/XsVPRwXUx4xhn8tgXLHjZ39FeSCzEqCmIAkuk+hQrLCgg0mUZT8Eo1B+9qG4FYbzB8kfmG
 Mv52dnkTgKYYXAsbXlSKi3QdBzoZ+Fde1Le2xPEz+8JhOXHolvJOo52M7hIox+f7lFRDfBhYeXe
 s/E3WNjbL0zXO9jrMVAsuQSzJt50Y43vOaOTtOK5lPeDou4BRiw1ag8tKxGcROMlk+VVg5CKTW/
 OMEEq97yzIbTQQhwxiyeZKrapb3K7F3hSlyOs3h8DNLthiEIu99u+53a7bZU3d7fb0H2HjN6ZJS
 vjY3lxPjMZzwpD0j2z9jvvD2SOtMCsydYMiH0Hmfb7Wys31nWhSfovaUkfXI3xisHfdn/UlkBoF
 gmzQuFyXMEHzrQA2Fqw==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a55c2a7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=4-exsm1T3CILtrYoWyMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140047
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12455-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:agross@kernel.org,m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vishnu.santhosh@oss.qualcomm.com,m:chris.lew@oss.qualcomm.com,m:deepak.singh@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vishnu.santhosh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishnu.santhosh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 513DA750FF4

A SoC can have multiple BAM DMA instances. Some of these BAMs are
powered by a remote processor that enforces XPU (eXternal Protection
Unit) access control and reads the per-channel descriptor FIFOs as an
AXI master under that remote processor's execution environment, so
their FIFOs must be accessible to the remote processor's VMID; other
BAM instances on the same SoC are not behind such a remote processor
and must not have this property set.

Add an optional qcom,vmid property listing the destination VMID(s)
that the affected BAM instance's descriptor FIFOs must be accessible
to. HLOS is always the source owner and must not be listed.

Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
---
 .../devicetree/bindings/dma/qcom,bam-dma.yaml      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 0923fb189ada9ee435144e8490c64ecb81edc57d..d256340d3f32e81eaa8c1e275c2a99aac888aa90 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -12,6 +12,15 @@ maintainers:
 
 allOf:
   - $ref: dma-controller.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: qcom,shikra-bam-dma
+    then:
+      properties:
+        qcom,vmid: false
 
 properties:
   compatible:
@@ -29,6 +38,8 @@ properties:
           - enum:
               # SDM845, SM6115, SM8150, SM8250 and QCM2290
               - qcom,bam-v1.7.4
+              # Shikra
+              - qcom,shikra-bam-dma
           - const: qcom,bam-v1.7.0
 
   clocks:
@@ -81,6 +92,21 @@ properties:
       Indicates that the bam is powered up by a remote processor but must be
       initialized by the local processor.
 
+  qcom,vmid:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+    items:
+      minimum: 1
+      maximum: 63
+    description:
+      Destination VMIDs of the remote processor(s) that read the per-channel
+      descriptor FIFOs as an AXI master. When present, the driver SCM-assigns
+      each FIFO to these VMIDs so the remote access does not trigger an XPU
+      violation. HLOS is always retained as the source owner and must not be
+      listed. Optional even when the qcom,shikra-bam-dma compatible is
+      present; not valid on any other compatible in this schema.
+
   reg:
     maxItems: 1
 

-- 
2.34.1


