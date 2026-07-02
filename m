Return-Path: <dmaengine+bounces-11955-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OMvxBgQ6RmrvMAsAu9opvQ
	(envelope-from <dmaengine+bounces-11955-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:14:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3756F5B5F
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:14:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=U5OXtGkc;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JMMJ2VPt;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11955-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11955-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CF6F325C99D
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C94C957F;
	Thu,  2 Jul 2026 09:51:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1A64E3771
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 09:51:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985912; cv=none; b=eo5+LflPFKfLEQxKNc/Dz12OomUfVbT4DFXB1usB6LcSgzGKKo5O5osTCLZ71dm/EL9OZvm6CsK4ZB7/xr+nxLEheiTk+D9eBQfBwPvBfIeGEK3ov9xHruhxU5XT0QeGjylIqreElgW4QylIYnrf8Hbk4DEM4LQslk1/xpcWQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985912; c=relaxed/simple;
	bh=CyJKamB558EN+4VM+bOlyULyCfzVWe4aNjOJYGteZtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgCARvBZ2iBhn9G98zN905gewdjfpBdmmFZV9SlNnTozvSxltcnPK2baAicYjEG6mAWWuBcyPAl8YmVi+qyYydrRr9/96NOdSdbX6Bpz+WesRMYKCZgAjQJVeeOUVU9cDiRxua9yQnqSkH1OJ2ilOjNNb3EQ82UAzso8JfPSIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U5OXtGkc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JMMJ2VPt; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629Ks984117155
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 09:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FECmNJCRt1DheqIEn29c8riI+k7ZRW03OOEFpW2dpNQ=; b=U5OXtGkcVGNLo89c
	bqh4Mx30G5nlbCp0f/2sRE8A33UU3KLZf7eXbF2gBe2HzqmzZll7PRRexDEFsy53
	6f+MsD9u9vMXhjlJY5Ec5vWbFWcak3NLGKIPs+tm/txV/0eDEz+jiv8qK6k1rlbd
	K7yusvnK3umSg/J03TxG208erDW3y+f44o4knPrPnARZchUFGHi3kXjzeOcWQsUb
	pmWaS1lH882PuQIcXFw4EpNMv1k1qOS4gkyEFBsWe5uabMS0K/UGTexQUmNz+/E9
	XpdX/lnCOEiZA13xid0aiHqQRqlDOEWobPz2J74GfEwjj8N/UwEQBDHNdP8dZnjH
	AF2avw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bg44g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 09:51:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84696ed3b24so2159727b3a.1
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 02:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985909; x=1783590709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FECmNJCRt1DheqIEn29c8riI+k7ZRW03OOEFpW2dpNQ=;
        b=JMMJ2VPt98fHosIv1BgyBVGgZT2NzG7U/She19XIiHihmU9e1fUGp6SZC1lObwYhtu
         tXdEjLcK5emGcXosxOkJw9LL6Z2rWbdYrp+IaZ3Hya5azMgV6PCS8W5qbQ5stL6XQL/F
         vhA4Zv0M8jRvPVqZR898tD5pwb4npIp1bRsl7OG8eZBvli/wi2Q3xKFyS/txaxWfZe2I
         UfFsvE7TUA9hrLbhkweYvPy3NRhXjrHaouKTf3VJTYUfgSzb+wiLmqNLceaEyAzI8/3Y
         K0a5W6b5J4jlIqGS91Mf6+54p702rNvTLL8qz92hQdoyateHrVqJ0BGVerw/graXa3Cp
         WWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985909; x=1783590709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FECmNJCRt1DheqIEn29c8riI+k7ZRW03OOEFpW2dpNQ=;
        b=lLxxxvJ0P49LAaVD2bfBiLIcBw5NNvnitINnP9qmLCfpmvxxNGsmyMzXTesF95p4WZ
         GWM7kTMQ3okZKFPD946lLscUyH2IiSGp6fhavChBh1LvSlCV07uXruKPvAuLkeZ+ieq4
         sq+lzJI5ygEdzvUiX/sFTBu33/epdhJM54bls52Z693f5ghw/phYJhah9rm0LWItp9t0
         8QMxouWhKColpFuJNlT7tCeWKtbg0viyXYmdX35BHXk2UCUEC3GEzedJNwkQW+S5OuY4
         zrFt40UECTjcesUB022USUUMbJOafbKRHUkCihv2yu9RxVUTsqqggA168Ung5lLTYwhB
         hTJw==
X-Forwarded-Encrypted: i=1; AHgh+RoiRxrvbnYXgzz7XI3xwISukOEKpF+RR8YlSK/9P58JFN6tx8iSdZ+4ecvME7HGNmorUGR9DuyEG88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXftFpn09niWW5CeKN+3rD+N3xFf7sIQdE5lF2vaqw5sMTReM7
	q12U2ZHy5LTqJMJZUrLljXsea+KOn6sooZ/nl2UE8yHXnmPrrUs6H8U8oc+35jgvaCqvHE3ios4
	yrVbcVZANJkW+9JhsjoINdfAo0MMJN4rx2Ge+X27Ya38GA0qS81vUkCFdUhqkLm4=
X-Gm-Gg: AfdE7clfKI26xijSDt7W6hjFYo0P9xr8UPKAfxeK5iD845TULoEYoTGCROrR5OJorTD
	KcwfReQPvD4aod5IHQO62xl7+svbCT3taIUNoA2hnOJ0suF4127iflnrq7ZNaD5LDAV1NETDxxa
	pJd3H6lOFjjhtpd3mNyNiX/WM5wIcVqrN+X4lX0FfIffQyW6Jin1Wnid2y+cITwOORZ7LLbNZpk
	Ai3ajnI6Y7xCyPduQlt5xCYc5F7Mlq6uSxDesFdq0RXhyvbeFjyR7PiDr2husn90Yui3YGZrHp2
	lYVM1FvesAT3HMWZv18ZKOjpyoY0r2PaKRW7wB3MTzi7YZkpYyiNKAa1pYK6vKnHS8TeVE1dtRL
	NTFNHRT9191qdYkhuTAv9U43CJg==
X-Received: by 2002:a05:6a00:e8a:b0:842:5ea5:5fdd with SMTP id d2e1a72fcca58-847c0854e2emr5136381b3a.40.1782985909437;
        Thu, 02 Jul 2026 02:51:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:e8a:b0:842:5ea5:5fdd with SMTP id d2e1a72fcca58-847c0854e2emr5136337b3a.40.1782985908956;
        Thu, 02 Jul 2026 02:51:48 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:48 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:52 +0530
Subject: [PATCH v5 10/11] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
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
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=5287;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=CyJKamB558EN+4VM+bOlyULyCfzVWe4aNjOJYGteZtk=;
 b=U9PotUnqaj9hqeUNC2+yfRb0b0mVqhgYiMSkEzdxBlm5MYZ9HQtJi3QN5cq6/qmurMNbl4rrh
 F+K6IRIRM42CuYEmj2GVNjtd4Pu8QppSfHnUpE7n91o798xjfIrub3V
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: kx9jKEwhvg6aGkaN_DgdvBVDmkwP_YgD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX7yaZG2ysoaoy
 d2Ah27PDD4U30+NAGoiYPCjUagCWgfGyLiZLK6swpmKRSeeWJeVEHJVB8pHkglAS8GJRpcQqGKY
 Jfjxy3L9DqWazqARnbO2tGZRsq7s2YE=
X-Proofpoint-GUID: kx9jKEwhvg6aGkaN_DgdvBVDmkwP_YgD
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a4634b6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=MqoitpKFJgFuN5IqptcA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXz3f+HtxkLvON
 TDnrGOitWj2TXYy6mCCEyGblJGwzvBLlBd/lOiisaKJSW0lH1N8oi2uihqiu4UIq7NUrHdiDph6
 FkWdebZtnkutfg9BKjciwRMD/IPTPHkyVpUd9YKDyzfjN9YE+Dj3otC6ygBaIMX3fweyRt6zNHO
 VyOEtNGBtDb1Y8HZ0gHw9LCWN0Zumqsjw3O6srxEC5ndFjECJ4zxGmPdsZut9rR3cy2TLSAKU/z
 3tO9BKbbmyBSvfdmeVk8P+B+Eb0Em5IzSikJMGHYKAbmSbat9oKak+pRURflh3yWlbgiF1kNhFN
 RsrfgyjeKi5aa2XYYFgYPUlXORu3bRV6QF4AB7SUTBngvn4c0R7FDNht89rcaZR3tE9dwjO1B+O
 2JgYCLHFipzR0AH9NzU0cjBEslutvCbkGo5JqZpklvDhsAc+T8I/X8Cx1+5LVObJ/eMZA4VlcSX
 zTDv7qDGldjgXoUfXrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11955-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:yepuri.siddu@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA3756F5B5F

Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
EVK boards using the WCN3988 combo chip.

For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
board-specific regulator supplies across CQM, CQS and IQS Shikra
EVK boards.

For WiFi, enable per-board with the appropriate PMIC supply
connections and calibration variant selection.

Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 +++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 +++++++++
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 61 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 26 ++++++++++++
 4 files changed, 123 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index b112b21b1d79..c9409ab0a3f1 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -16,11 +16,19 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	wcn3988-pmu {
+		vddio-supply = <&pm4125_l7>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+	};
 };
 
 &remoteproc_cdsp {
@@ -57,3 +65,13 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index e62ba5aef71f..58fed6cc5925 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -16,11 +16,19 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	wcn3988-pmu {
+		vddio-supply = <&pm4125_l7>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+	};
 };
 
 &remoteproc_cdsp {
@@ -57,3 +65,13 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
index d0c48bad704c..4b7be09eb5a5 100644
--- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
@@ -3,13 +3,74 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+/ {
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
+};
+
 &qupv3_0 {
 	firmware-name = "qcom/shikra/qupv3fw.elf";
 
 	status = "okay";
 };
 
+&tlmm {
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio88";
+		function = "gpio";
+		bias-pull-down;
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
 
+&uart8 {
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+		max-speed = <3200000>;
+
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+	};
+};
+
+&wifi {
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 727809430fd1..864c0d2636e6 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -16,11 +16,27 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	vreg_wcn_3p3: regulator-wcn-3p3 {
+		compatible = "regulator-fixed";
+		regulator-name = "wcn_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	wcn3988-pmu {
+		vddio-supply = <&pm8150_s4>;
+		vddxo-supply = <&pm8150_l12>;
+		vddrf-supply = <&pm8150_l8>;
+		vddch0-supply = <&vreg_wcn_3p3>;
+	};
 };
 
 &remoteproc_cdsp {
@@ -57,3 +73,13 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm8150_s4>;
+
+	status = "okay";
+};

-- 
2.34.1


