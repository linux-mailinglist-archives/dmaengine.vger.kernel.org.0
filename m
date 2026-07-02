Return-Path: <dmaengine+bounces-11945-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /dKMLLs8RmocMgsAu9opvQ
	(envelope-from <dmaengine+bounces-11945-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:26:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F86F5DE5
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:26:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="DPGLm/3F";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UNMNfLKj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11945-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11945-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A79E031DEC63
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE83D47ECDF;
	Thu,  2 Jul 2026 09:50:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FEB4252AC
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 09:50:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985858; cv=none; b=I7QWp7AnXkk0YReZYyu9hJ9BnPo/yjqtMSXAByBGdElFZjAwXu45m79HF3j36EswrH8xfl+HAyqFM+7QCVAkHxPuaJ7ChOt8gTFcU4w24Jih33IfbB8yxT6XA5EskPVBOrQGy0RtRbTqMm218RP/yFSxZdaslPbfodK15H6+kWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985858; c=relaxed/simple;
	bh=/TKztqHNu1ktZUUR/gy9QSyGNP4CR2tBnk8ugYs17X8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bI5BHwfCp3xeFogpDqhKjz+5+hKnTPgjENxR/3O8Eoe14cBpRxV+KD7KPvdxZPPxtkO3nFP1mAA58lrdyYQuVdw10VtOVOINzygr3KtcvEIKGX7lSjAfNS4/nWbn1ndMoyGyUVw9BECiYjxWUeabUvUgvpC3qaqeXwNbQMYzXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DPGLm/3F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNMNfLKj; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629KnBN4116734
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 09:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8cpCdcdxZefnhRwM4qHY15
	IjCCDyyudibEtw9KMCnbU=; b=DPGLm/3FfdGycMLNCqw1shY4pY23ZYPyMPxcAF
	7uwBvNnxKIc1HSuFwYUeY8JI5Wyd2jnLDfeSAH8OTsc5puxmY9aNKLgscrD7+ymy
	v63nO34dCRW02IFZqs0AR21dh15Q3U/aUNkUdkc9Sb8dOiexa4u/8PFu3G/6Q/dm
	2+eUHAWIPA1guizrYfWuFItQ3McSivp7qJFmPggIIjUiNsmnwnFH6MQTN/AOuKCz
	ILhTMeX6VBUmYKu/57VZe//OVHl+FqMqagc0ci5mQwk4yCMftjbMtwJjhgzR850B
	3HFt5MbYeJ2x+AFriYTovfV7vGjzz0VbkN8G8VmuT6BiAstA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bg3y8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 09:50:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84786d85ec2so1860371b3a.1
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 02:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985855; x=1783590655; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8cpCdcdxZefnhRwM4qHY15IjCCDyyudibEtw9KMCnbU=;
        b=UNMNfLKjizRy+JsN5jNbLq+HBsbukc+EsNwwy2nHPICRER/iXiOdElV5AF2BBs064a
         Ru1uZJwTxgOPB/fiUglClu+hnLW9g5wb4Nyh7zDxia/DHlNRvbWl91ALjhOYk3Nvp5JS
         ErVquqwdEFK38X0u6L96olTDbfM5grQ9hhFpmhKgBKtvwpkNqvEZXHDixpqaiW+BL/OH
         2zWHiPxhW43jrMnALm9ZgD/5g3eye2CepOx4QwrXMcnoLT8wVpKSmURz/pKiSgGjv8FS
         qgdSfgA6LkIOHu0nJ1Z8TSim02VDdQwdpGsxg0HMvl517lP+t7GKcUoYgAffLzpLTsaq
         fZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985855; x=1783590655;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cpCdcdxZefnhRwM4qHY15IjCCDyyudibEtw9KMCnbU=;
        b=QmdkJZ2GY5C682sYtnJG6mTuww5/IFsgt2c8zNts3mvc7/gf7Dc0Ult1BaY30TnAD/
         w1AwFFGwq+TIcz++BisoU1b+Vzdjnx132lBPuaZfYpy4s+wIlNv/dMMdvoY3MkcNAk1u
         bcY2PWY3OQnLrzfW8UlgzOXynRnRr32qXwwCSME5a4Pp+Icl0KRjBBRJPywRuA/S1n3w
         uPCswaj1Sbyl2X0GP3QesiRndLTQpVIfrWowSWPlQhyE7wJUNNehs9N/q/3itLmGlesz
         c8UUtcKAqyXMlaPcHrCrii3DudYy1+W0BSvSDI7JkKw+FgzUf5ONSjWsrANU6j9DHnl7
         1avg==
X-Forwarded-Encrypted: i=1; AHgh+RoXCub5yUDvVxpNocU0VaZmdgj3Brh6EFv5HzCArY1iTYrBzP8uFrrq/5aTlCTY985GDFL5Dr8AiPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlCeM+ijdZZ0/HWn4APO4bj8W+Xp1Gnf0H9IwQ8DxmBhJuYpA/
	gGaZ+4Qc6t3HMSXUEibNEVUXfpUKDoYY9iw8cOrZZGwNmDmr5ytvrRHMj9N9P/ttciaOcVniRsh
	u1jWFDkkxdwz6tAzgt3WdaSIvqTTkrp/e6K36Wh3043+C+M7xxlujqf++MxqXRi8=
X-Gm-Gg: AfdE7cmPMGhQ7GCLSMxDHKWY67qa0FzzrXCVMoNu/j/U6aozch1Im13f6vC/oUwUnGn
	egG04Dx8stHLfqMlsxzENvqKWENTgohIGJxm2l/D1Z/gw4CjXnikmIQ/lP0LBhVDUr20Nki94dc
	7kC8wXgyHWooclkRZWLTsKp26//5k9Es1vMDqNQ9Sn+ne2ON7WqgZsQFXnNfkCdgiji28mtDIpY
	OD24Mva7nwsNju44KOQZ0EsrgSa4vI2xDtmkCQb8TTxXapmvC1zmdnbk6zgrGAPoldkGDs2VBAN
	wKV0OyutPoaIcsXOrtTLVNZDRMS6aSEtfjp6EBaf70w+KBKyfD3aTnKqgK2aFl9t+sNQE8BXrgr
	w9FWQMc1Z9BC0HMhHq9xQ6rvnbQ==
X-Received: by 2002:aa7:9309:0:b0:847:759e:f617 with SMTP id d2e1a72fcca58-847c0a3c9b1mr5338757b3a.44.1782985854739;
        Thu, 02 Jul 2026 02:50:54 -0700 (PDT)
X-Received: by 2002:aa7:9309:0:b0:847:759e:f617 with SMTP id d2e1a72fcca58-847c0a3c9b1mr5338727b3a.44.1782985854140;
        Thu, 02 Jul 2026 02:50:54 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:50:53 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH v5 00/11] arm64: dts: qcom: Extend Shikra device tree with
 peripheral and subsystem support
Date: Thu, 02 Jul 2026 15:20:42 +0530
Message-Id: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHM0RmoC/3XQ24rCMBAG4Fcpud5ITpMmvdr3WBbJUYPW1qaWX
 cR331hdLKI3AxP4v8zMGeUwpJBRU53REKaUU3coDXxUyG3NYRNw8qVHjDBJgAHO27QbDPYjbik
 mivnguGKhjqhE+iHE9DNzX9+3fgjHU1HH2+MDbaqZFEz/kxvn8NC3pbr9LmNGtAg+xsgtaSZAy
 4nuYWDiHl6HPuf1nmNgzMQgolURmom/TFG62MLX4HUtQEghm0leA9bkgF3XtmlsKhmUAOtsrZw
 GEzWHMhcRxPoyneOOWel9rQS67rtNeeyG3/maE50Xfn24qdwOR6BGK668Neazy3l1PJn99d9VK
 bM3sYXByZPBiiGtBUUJB0/5G4M/DEnok8GLQWLgUXkdnFBvDLE01JMhisEoFZwQ0MLIF8blcvk
 DJ/4zU2sCAAA=
X-Change-ID: 20260525-shikra-dt-m1-082dec382e7f
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Anurag Pateriya <apateriy@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=5256;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=/TKztqHNu1ktZUUR/gy9QSyGNP4CR2tBnk8ugYs17X8=;
 b=JwNdPb7c1TDbauwuBbqidoMvDkPs5n/FHUjbTztorGYWWIwGueFoKU+EHhfYXZT/yBXSwEn74
 IncyjbtosJAB+vRi1hfQTfSELNqqUBkgYvc+rqHBF7Mw4jokZOPVYhF
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: ffQDXXgneZz80WH5xPcG6cNK_CqLqac1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX7WnJ7iGdQY/n
 ltroQrAOA1K6+FhL+xqfWg/8T+khdsfr9sW15uFCbG1mp9j8vI+ug6MHiLc54gQYqiVXZW7H4xG
 28+/kEXGN1SdpbwM37EcWgRF0JE06Ks=
X-Proofpoint-GUID: ffQDXXgneZz80WH5xPcG6cNK_CqLqac1
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a46347f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FrY2Icr_-yWe-lCAmnUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX0PPpcaxkMmYL
 jxdh0UwEg8z/tfD4vzfObRBfRUFFVCCDs8sM1riabglXODYbeuGN6pXVzn7lDjYmzQAdgZIpXvl
 kcJUa0xo1g4l+XsKBYxe5J0ijTPTL/bIVDAHe+7WtZR2XmGNviQzgdovYrHq7dAy1oN8NIxYeqh
 DuzIy0zf/lABLVOUAjanV4hdGwcXur+kVJZash5x223pudrRZB0b2fGeM67aPp9h0AfCvC75ByP
 qvjgBeeLw2zLZtysylKOtA+IHfKplCAlS+xXJjs+RlSKdgZJaVza/rClBbRa0wMl1giCA5gymWl
 GrrhbgHOstagg5OcSSizzgX5eCrPmyirl7GyshXIi9DnI+6DexDZqPrwEki3ep0z9/dwK2uKisX
 Y/6nwlo+6F2zmTXxrkyLid90UdIE494HqI9vBPv9losMj0+KpDdEYqcsEb2g4+eRna9H67t7WtG
 LhjDy8q9sWURL5Epd3g==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11945-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:sayantan.chakraborty@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:xueyao.an@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:aastha.pandey@oss.qualcomm.com,m:imran.shaik@oss.qualcomm.com,m:raviteja.laggyshetty@oss.qualcomm.com,m:vishnu.santhosh@oss.qualcomm.com,m:bibek.patro@oss.qualcomm.com,m:gaurav.kohli@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:yepuri.siddu@oss.qualcomm.com,m:apateriy@qti.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 032F86F5DE5

Extend Shikra DT with peripheral and subsystem support across all SoM
variants (CQ2390M, CQ2390S, IQ2390S) and their EVK boards.

The series adds:

- QUPv3 serial engine configuration
- cpufreq-hw node for hardware-assisted CPU frequency scaling
- DDR bandwidth monitor (BWMONv5) nodes with OPP tables for dynamic
  DDR frequency scaling
- EPSS L3 interconnect provider node for L3 cache frequency scaling
- CPU OPP tables to drive DDR and L3 scaling per frequency domain
- SMP2P nodes for CDSP, modem and LMCU inter-processor signalling
- Remoteproc PAS nodes for CDSP, LPAICP and MPSS subsystems
- TSENS instance with 14 thermal sensors and thermal zone definitions
- Bluetooth (WCN3988) node with board-specific regulator supplies on
  all three EVK variants
- WiFi node in the SoC DTSI with board-specific power supply and
  calibration variant selection on all three EVK variants
- Gpio-reserved-ranges to tlmm to mark GPIOs used by the SoC
  internally and not available for general use

This series depends on:
- https://lore.kernel.org/all/20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com/
- https://lore.kernel.org/all/20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com/
- https://lore.kernel.org/linux-clk/20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com/

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
Changes in v5:
- Split the WiFi hardware description into a separate shikra.dtsi patch (Konrad)
- Moved common WCN3988 PMU, Bluetooth and WiFi properties into
  shikra-evk.dtsi, leaving board files with board-specific supplies and
  status updates (Konrad)
- Added missing CPU OPP entries for 768 MHz and 2208 MHz
- Added gpio-reserved-ranges for TLMM on CQM, CQS and IQS EVK boards
- Collected tags fron Dmitry and Konrad
- Link to v4: https://lore.kernel.org/r/20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com

Changes in v4:
- Updated commit message for first commit of the series (Krzysztof)
- Collected tags from Dmitry and Krzysztof
- Updated wifi fimmware name (Dmitry)
- Link to v3: https://lore.kernel.org/r/20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com

Changes in v3:
- Add missing interrupt affinity cell (0) to GPI DMA interrupts
- Link to v2: https://lore.kernel.org/r/20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com

Changes in v2:
- Collected Reviewed-By tags from Dmitry and Konrad
- Squashed cpufreq_hw, EPSS and OPP tables into single commit (Dmitry)
- Removed labels from CPU OPP table entries (Dmitry)
- Squashed CQM, CQS and IQS remoteproc-enable patches into one commit (Dmitry)
- Added WCN3988 PMU support (Dmitry)
- Squashed Bluetooth and Wifi changes into one commit (Dmitry)
- Link to v1: https://lore.kernel.org/r/20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com

---
Bibek Kumar Patro (2):
      arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS remoteproc PAS nodes
      arm64: dts: qcom: shikra: Enable CDSP, LPAICP and MPSS on EVK boards

Gaurav Kohli (1):
      arm64: dts: qcom: shikra: Enable TSENS and thermal zones

Komal Bajaj (4):
      arm64: dts: qcom: shikra: Add cpufreq-hw, EPSS L3 interconnect and OPP tables
      arm64: dts: qcom: shikra: add WiFi node support
      arm64: dts: qcom: shikra: Enable Bluetooth and WiFi on EVK boards
      arm64: dts: qcom: shikra: Add gpio-reserved-ranges to tlmm

Sayantan Chakraborty (2):
      dt-bindings: interconnect: qcom-bwmon: Add Shikra cpu-bwmon compatible
      arm64: dts: qcom: shikra: Add DDR BWMON support

Vishnu Santhosh (1):
      arm64: dts: qcom: shikra: Add SMP2P nodes

Xueyao An (1):
      arm64: dts: qcom: Add QUPv3 configuration for Shikra

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    1 +
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts        |   41 +
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts        |   41 +
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi           |   61 +
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts        |   49 +
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 1682 +++++++++++++++++++-
 6 files changed, 1861 insertions(+), 14 deletions(-)
---
base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
change-id: 20260525-shikra-dt-m1-082dec382e7f
prerequisite-change-id: 20260429-shikra-gcc-rpmcc-clks-2094edfff3b0:v5
prerequisite-patch-id: 59bb0a7828e41f546f734f127d81da83c0adcda9
prerequisite-patch-id: 197da6bcb15cadc47869dba88c8020987b25c335
prerequisite-patch-id: 8ec9c1eb03f052ae232ed54117abed38672c23f6
prerequisite-patch-id: 350db4f4bcdfc0fad9ed57cd5b1723f85ad44f5d
prerequisite-change-id: 20260524-shikra_epss_l3-522afe4fb8f5:v3
prerequisite-patch-id: b5d7f75df02fde56181f576a936baf09d0a72276
prerequisite-patch-id: 3ce52e07ae57139c2e2b71a29ed7d7250f6fcc87
prerequisite-change-id: 20260511-shikra-dt-d75d97454646:v6
prerequisite-patch-id: 3a689e8dda5fd2755b689d94d095806b3f2e6eed
prerequisite-patch-id: ac83151a889855498d36288ddd36216d451340c8
prerequisite-patch-id: 2357cac636e019eaf14d6a493a1c72bca56fe405
prerequisite-patch-id: 2885f299e711582da312ca9d13983d296a3dd5dc
prerequisite-patch-id: 91af5f3c01e766a53ce8de69aa21847a2d6bbbf8

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>


