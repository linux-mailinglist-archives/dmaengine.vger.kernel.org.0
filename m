Return-Path: <dmaengine+bounces-11053-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN5vMaMvG2qU/wgAu9opvQ
	(envelope-from <dmaengine+bounces-11053-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:42:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD186124CF
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78DB73027958
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B5A3C3C0C;
	Sat, 30 May 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hb+nW6Hz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f4VYxBi4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB33C1963
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165689; cv=none; b=qfliWZwVow53hM8LlAtGj76DIradhXi3dRDhQU6poSBpPmOz6/UmVh6sVvX9rq8VRPuCYO3JqXZn7DyUMtNC9voRWv1STR2DyhrmKwIftjG9ec8cIsuECQS/miplR3guTWc2si4Nw2oPyq49CvzeJ8gJBJGzT82p7GiAX7SKs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165689; c=relaxed/simple;
	bh=xt8fdY5E19585IRxlf2tv2dOaGtOy/UcGSJMOtFMvaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIsxNLaBJCcIiyuzFgUG3DYW16FZEJHvd62UcV8LNvH/Um2mOFSgc1vN7ggfs52C2fzlGDqF5Dxvvyo66j3h8nDOdMAztIjNyFt+XYre8U4ZjgqPFOzqVko5lXu+NKHKJGqnO60CfTm7gHbxhF2xKKKICXv7V2zInDco3xmGzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hb+nW6Hz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f4VYxBi4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOSaX3280264
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=; b=hb+nW6HzBo6aCPT8
	AFWEK9qfbgYfr+nQ5QZoQubMiVtcQLZbqHH2vYpq+b7n96c+3As720L+eaLXD/rw
	yiV2XghXgKgBRaU5xYS7kbFAIws/lyG+IdyNfSV6fMssvMhQ98IxcX9BGdYXzPt+
	47BBqm7L1W6kz/BONgAoehEWqg0cOuGOQKqoexBkkcxhK3t+yoVTkwoFse2EKqsf
	uvJgSc3cuWiabe0bzLvBH1xEbhVNSYqMLhJ2R2wjJHCEaAtEwsW+o6/1S7FR3YUT
	0Gw2iL9qbqcV/MKjzAXr2cjHoh6DmdOyNmrppN4eCHcvMD13F6N5gnId+BKGvAyN
	e9SY9Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7f9ttu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 18:28:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso129983435ad.3
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165686; x=1780770486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=;
        b=f4VYxBi4QXIuVFatOTji3aEc7iswGE083B0DsSITlKhO+71bCFoQ7TjpNzZY5ox1q5
         n/peM0zi0SAV2O3ppjJvYHU7W9JunuqZDwG9GeAaCunQwjLsiOkmmiIXpvLehxTLvztu
         V419bIMLypP/0YqVV/KsYfHhIz/3nfwV5OCmbZdpnOeS4V4dpeTFFo5zu9DZ48YAL+xo
         ySrml4sl0CbkVJJMPw07lrM7mtI3N3lHKyuq3ORBTRIEeppl/qbS8vzozy3E2R73suk6
         aDEVu5oEh/UY9qEVSG/uWmkKKevkf1nxmhvDWwInPZTnp7d6ZsIG/QMWD6YGQ5LOP0Rg
         e6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165686; x=1780770486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=;
        b=pr2nEERlelMZxrkrVhxZ2fVP4G7r6kFaoy/Jp3/WCiBdwQW9FRaX1gWlTm1pyHK7dG
         I6Dx1c6TS+7hJy+f5kL6uR0OjkQxmLfAV54AZNcZWTXpHBd90KljW7+gaJOCLtnfy4Nb
         njWBF7vyVugC/hFWS5JzVyg40gFTlxiXXbxeCnK+UWMsOZmOV2pCT5mNFoL5rWs2ZuZs
         CMvqw9fpymaTaoCOyBcMu3JHVhLBaUJijR3HFG/5PJL0g45vkt4iZvBqr/TZyB9CllJ3
         oMzFMmEexWEV3LpSLm1itrcmfUD+k7b5g3F3CBEhvQ/II7dPjXGUfp0uQ9aj+08LD5vJ
         jydg==
X-Forwarded-Encrypted: i=1; AFNElJ84ytvPtcBNEb27w64l4a8PNHb4AMoIHDyvPnZN9xccCM+wymb978v9C5GRfU7o4dRe3DlJA6U+NWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/mh0m17aLwMmSGnGhmj1B4QjwK5jLNYUba7Vxex+4KDj5s4c
	eNRHQdvTUEmRw8qH2vCgHdw6rguwryMDPqxtcdRvwx8B8vNKcf7ExnHhnlweCGSGv6MxBqW5Mvl
	W7Hg+mk6kh294TE3Xb4BKbT2ltW030kJ8ccAdggFZ0H/dIZqckTFOrfsjhePZnEvvQJlej5w=
X-Gm-Gg: Acq92OE7zGmKMXDE9cOL/7soir6vlhCqBobHlEPRF7JLq1Wvs2zeeSy4HWi9yO99dHC
	1RkWzlEnLTD4AxQ5NaDkI9h5Yagd1CSVOKi3IGojwpAqEDsh76YIBjtjM7J4HpBhMzGccuzZGnr
	+ApTBkP3VHi/XDyj6OngrDG38ScNQ0j/6qxp+KoP/cvA7bjh/4NIB284/HrF84NjUGIwJCZxSoL
	zN2/1UbxU3V6TUsCuJSR2FIJGrc3Yxgu192XVL9sLZ8i4bg3RfhxGj3z2aFa5hxYzxWokmfPGIj
	xjHnKYTu/IthH4uir4HKqudcK6oYs81dwqWawE9lL2TvUEH5v6so8UiJG3sBwrFaf/atE+RcCQr
	T76WJAt2ufggH5R/I/H4B+clbovFY3foMfUhsLBiFjaMnKJE=
X-Received: by 2002:a17:902:d58d:b0:2bf:2e93:c624 with SMTP id d9443c01a7336-2bf3686777amr51626575ad.27.1780165685884;
        Sat, 30 May 2026 11:28:05 -0700 (PDT)
X-Received: by 2002:a17:902:d58d:b0:2bf:2e93:c624 with SMTP id d9443c01a7336-2bf3686777amr51626215ad.27.1780165685449;
        Sat, 30 May 2026 11:28:05 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:04 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:20 +0530
Subject: [PATCH v2 02/10] dt-bindings: interconnect: qcom-bwmon: Add Shikra
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-shikra-dt-m1-v2-2-6bb581035d13@oss.qualcomm.com>
References: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
In-Reply-To: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=1062;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=MfVD9NAJt+YvcfkJInifeQ/jWKYZMhdr3T/JUeWSDbk=;
 b=JfFkzKPOnxwJefF+ophXm/+6E3kPCWDQLamcirvNXm5y2bmtoWo49z64nFfax6b/sazioFKpf
 /V4tvER9/JMCoFcXKnc0dKFm5uw8jict7X34IeJuXg1bCBw2ue3Whgb
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: qHYE4Lwscp86XejEonymXao17FfATMYp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfXw5VvDTwWT2x+
 W128iVNl4Zv3AhYrL1Vy5/BzTi0d8Gv+dsE7YT7ECJ+L33/zwR1ArderkH+e8tq+9hqwseZkAQb
 KiFgmxvEc45NBXCwDmfXuSsoVKN8YXfXR4AH0eaZ2neFxfba/0xOVXVROyawi3pUjvgVdgi6rp3
 yNYwWyOupLLWoIYTsyFJFDH25wAsPsPUkkVNxGSfo0haFoQZMuGspCAA9DfGjecfgOGZ0Bgk9tB
 0hjxgB7HbkzjMOELQn7YwMp0ekKL3TGUeVyjr7BLNoOGD30++1CoBud7SHEwhi5CRqPL2mH+7c8
 alXUxsXqKap/WfHwH9QJLUQZaBc3UA66DGgP15yX0pMLuOM3AuDVA2QSzj52uCLzQk/3iX2+Ohi
 vDVEPT2EJO/PqoYq4xMh8CWDqo8wU4STy1CXUraIZ1ZU8oGZ6WL6X8HEGDN+zjztTfQq/T2lrfo
 g8lc09maTfryg31XzAw==
X-Proofpoint-GUID: qHYE4Lwscp86XejEonymXao17FfATMYp
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1b2c37 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=s2Q_muabT7T23weRVv8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605300199
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-11053-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6CD186124CF
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


