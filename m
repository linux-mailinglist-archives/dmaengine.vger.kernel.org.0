Return-Path: <dmaengine+bounces-11098-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNF/BjiCHWpwbQkAu9opvQ
	(envelope-from <dmaengine+bounces-11098-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 14:59:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200A61FB33
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 14:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60D9A306A95C
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4CE3803D8;
	Mon,  1 Jun 2026 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e0lJDomO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SJ5W11d0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F137F8CC
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318546; cv=none; b=kQbkQLzs0MFOHx8aF+HrIO2voCVTRABigCJZgOQ46RdG5CUwLUQXDDAqx5S5+v0w6gpvFZAY/t0svZ16bs8UN7oA9w9FiECVHSLizCm01evnFhNyvbKRbsK20RT3UY1ChG0mRfBbyejGhnxH7iANXFMV1SjppE5EQVmJ+1P7RWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318546; c=relaxed/simple;
	bh=DQT/zNqQq2aLAulWAmnNWMK9zqPYRi41u9uyToFunqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NjH9qmQOr8T929njSK/m6UtRK7JAL83voHgRX0lmZkq2gY6fCgtVVvuPe0i5UnJZvOiTkEigv/dsXsZmCOr3wJA582RnuX3dvzcPnqbXmkG8OIodgjMlAKvXbJb/rFwRfOlloCBsor4zEViQrlik2LLOIMyT+ij/vxTN5At7XXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e0lJDomO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SJ5W11d0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518f7DW2740402
	for <dmaengine@vger.kernel.org>; Mon, 1 Jun 2026 12:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F3241F3HoYz+LUKnQSLUvVf8IiSZldKm42safL2GW/U=; b=e0lJDomOEDodHrJw
	t7KQaeugdQXd842TpC4GgPU6uSAD0U2A/P321HRCMoMLgDiMy4hzBc60feF344dY
	4zBYlTl9eSLjxxSgy7CEGixH4LKbAMP9souvsHipoNUbBceL4KJx2FsU7LBkwwh2
	T5kNg8s1LEQ0jKVZLHtdTG/iRKDAG6WKgwclB4TCkrsbmRZZYZ9k0GB017JulM0q
	icW4xMK2G5y/G3kKYXCoN8BAKJtcI16DeNKOAbO1Ry0HgHGUnK1VJFq5MdvD0cIm
	jVmGHNHXQAWk4r8cS3kaGv6En+euLE70os2IscO+VhAL2yrDDJQnwMXseHFCIoxu
	tD8PPg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sqh134-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 12:55:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf0d79d41eso30107875ad.1
        for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780318544; x=1780923344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3241F3HoYz+LUKnQSLUvVf8IiSZldKm42safL2GW/U=;
        b=SJ5W11d01tfL7/xuGEU8J+347+Z1UHmskf8n9L6ys4fWdvz/qjNoqKCAmPNJCxnkjK
         uEEhcbN8La7J/KXNvcNhKo7mcBRw5y0UPzErKSTT4Bvnqwv2CviPgTSahBJI7/d+Z4Nt
         Yo2KiVAwTtb//8POIEymA0E0MlPzUSCPynmiR8enhOjLPqcLDksFRO5x0PToGNBpL2R1
         nBpBvKOsII7/4e7EC+lX7FWw81tgNbuGeg5KFhT2nOQEkFMHc3dvnfEudDw868jzb3rG
         WFPLoLhxBtpgSsOPbtVStBe+MvkDvIuLxRUuBwBmQ1Hwb4aY4C9evEXfLy8n4JD2lv2W
         6JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318544; x=1780923344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3241F3HoYz+LUKnQSLUvVf8IiSZldKm42safL2GW/U=;
        b=cmZNnjUzNTDgrGfqFMVrhsj1l2x4DgbuW+cyjlLSZj92o2wPnRCUW0X6G6hKeeimlu
         ebme8JAlhQGAkdiObYIhz0fblbuT4dMn38EwWHOdVThG603lnrgK0TOuyPP1WxRgaN2z
         mqvKtTKfjMCpC7YZP6KDfBuPb2Fc/LooqUKeYsAJ849gZc+91lVa9rzmpRv6fGBxDt5p
         hvjYJehVPy5Z8scm4wQHX+bTvSCQBK/K1aoOqkFHkn+FjI8aJtk8eVp/TK9sbn4bixhq
         KhUMGqGG2TibkjdJhP6nmfpUGpJkQTlL6AcdHRdYzv7IqXTfSsSJEK5zytCjW5Xzd1wQ
         O61Q==
X-Forwarded-Encrypted: i=1; AFNElJ878FI46tkPb8reQzh5KD6txRRJQW7d8NbkExSgsf8T7KwBnXuW9/uAUD2tv60E2M3CLbc17d5FZiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXRVj0kwBbCm3r35K+nS2BaFP2bjN8rVIrgtOkhMENzLWA57Vx
	AbJ4RWIIIXK/XXUthEHGEyx4eHoI147WbAxTwWDXMSMeUUnuvHnasHHvOD7drzh4qubq53uQgm0
	0LJ/oSjYPBFm5HE+/h4n1QjtTmgVI89ha9s7uQWpHiQTcgOnoZXiyDmTaoxC8158=
X-Gm-Gg: Acq92OHBQc7kBOeCdu4HcrVfUG6Eh0R7Lq1IHMFoHIv7V4FzX66Wk24AQ53iqBEyVNj
	E8B6z5z+21fwABpeAGYJVEHv0j3MObbCOxecpCw4WcDbfRdgRdkD4H7RUGhK0/cy5dBqa59tGUt
	Y8lL3rHWaUP/Iyrs8MIevVK35yJvC+NW1qSPvtHviyFaGGpptlT5Rh9zzu/Mr54TOYN+yYZtOPu
	t03WgRngO+GW8E5cq8ggNT5ERrGGpwkeC0Jtt96ZXahq8IGywXoYVYG9jG9qZWS7ihltD7ED0i0
	CcFhGEVQbyiG8asz4iBOMmEOJNk0+gfVzJ316eB5b+mkQujW1BLxoitaQVsYengXcmP0sKKEWhj
	siZuYgLXjgMht4UCSj0zAE7PGggiZdAc/1QRhLn+v6IPxWMs=
X-Received: by 2002:a17:902:e5c2:b0:2ba:bfb5:9cc with SMTP id d9443c01a7336-2bf36845817mr120232475ad.26.1780318539909;
        Mon, 01 Jun 2026 05:55:39 -0700 (PDT)
X-Received: by 2002:a17:902:e5c2:b0:2ba:bfb5:9cc with SMTP id d9443c01a7336-2bf36845817mr120232215ad.26.1780318539437;
        Mon, 01 Jun 2026 05:55:39 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a21f0bsm98584135ad.34.2026.06.01.05.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:55:39 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 18:25:06 +0530
Subject: [PATCH v3 04/10] arm64: dts: qcom: shikra: Add DDR BWMON support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-shikra-dt-m1-v3-4-0fe3f8d9ec48@oss.qualcomm.com>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
In-Reply-To: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780318512; l=1830;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=7ByKGzzDTD14i4DIQy9VognEH4x590vwDySV2Co3gPA=;
 b=hQcsrUaYE+lPYPhOENh5Mi9JLSVf59u/lz7MVOJSNTwwHFicYTins8Kdat+EOHLFrfY8liQUv
 e0MKC4c9uINCxtAZCyWsdiX39igkyzGbCOvjRclTEjDs/x/CQoTBiMI
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: nLVl4SU_Cs_pVaMd6zaoc_CQBlwA1bhY
X-Proofpoint-GUID: nLVl4SU_Cs_pVaMd6zaoc_CQBlwA1bhY
X-Authority-Analysis: v=2.4 cv=eqnvCIpX c=1 sm=1 tr=0 ts=6a1d8150 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=iYP2JlN40lpobhLRj-8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyOSBTYWx0ZWRfXz3/9U9YoRJcz
 4wEOPmrvVpeGr//FQF9lEgJGNxqQyPEXD4dSFFNTkJqUezVCgDz52YMkkhLOJiKGqDCz3FHL61g
 gtWEkIsyFlVG0pJPIJjYeWk/9e0bvd1EX5MZ/z8kr57uMKlZHfRqSbE5AO8RN1HdwlcBl09uApK
 cP21KQZjpCfrdbajWNrxQDw7WscbgjZoVM/cvIJYO4jrZo5K33Sz/0LsDfDanJJxctehjioXwle
 JFRt4OzAYRPf/mPxrrH6X316WfbkTGyu3/h2aARiiNZFngcqlborOyjSFkUYwNx/F2gxf0/xOXm
 QIDxQr1EomIbcSPYUTnZMwMhMgG9Lh6rMYofYb6iazX849MbbvXoueRTDT+geBn+P9foEvHeU1u
 I4YxrmRwRxCr7+AzIY8XrK+7JVu+Qx8jis9obw2P8nbFSJSOSyKYq3AikT70YyUwSKrLSEbThCk
 o1+FWp9h8A8jQIHj4TQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010129
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-11098-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,c91000:email];
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
X-Rspamd-Queue-Id: 8200A61FB33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
Shikra SoC. This is necessary to enable power management and optimize
system performance from the perspective of dynamically changing DDR
frequencies.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index e6ec07a865f0..ec1bfebed226 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -661,6 +661,46 @@ rclk-pins {
 			};
 		};
 
+		pmu@c91000 {
+			compatible = "qcom,shikra-cpu-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0x0 0x00c91000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <1200000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2188000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <4068000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <6220000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <7216000>;
+				};
+			};
+		};
+
 		mem_noc: interconnect@d00000 {
 			compatible = "qcom,shikra-mem-noc-core";
 			reg = <0x0 0x00d00000 0x0 0x43080>;

-- 
2.34.1


