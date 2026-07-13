Return-Path: <dmaengine+bounces-12389-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fM7rAq/jVGpAggAAu9opvQ
	(envelope-from <dmaengine+bounces-12389-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:10:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A10FD74B58F
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:10:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NMRute2v;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="E/o7DbTO";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12389-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12389-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B14D030DE012
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00860426419;
	Mon, 13 Jul 2026 13:02:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EB5425CE5
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:02:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947735; cv=none; b=n9Ufe1KIaGz5lE2rSlqho3YBslp65NUx/G/HdwkTntImmH42TPW2SgIogmtHLL5IsNChJzvUQz5vVkqq70wLVvnQjOqgX6pOzEDn3Ff8x1xIu0m7Z/eTuYAtEcaLOoU3xQBhz01Vxxw9Be1pi4vMHOFbrWy7llgQ6RlB07bmzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947735; c=relaxed/simple;
	bh=xewtmBe7Tjse/Oov1uLM7I+VZpNX0SB8ljw+4HhCUeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=up5aOtYmx3lOzEa/lDR73QRT+UZX4kRZWD5CRoW4rdqWFlmQv7ZuqvTnvx4+fYfrJ0hh59eXReKrsHJpzCPCPs9YwIsv5P56ThiLLPALZ92m7MzylO232liTyhGQnP4gRveDAedDlXcYMdmPUdAWfRKMscwcIyNQK/3R6E9N2TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NMRute2v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E/o7DbTO; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDeEs1480748
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MsWDKH/w5P6MtO/VNux/FoMTI22L7P5oBEgCNW8qbYk=; b=NMRute2vZku5bVXS
	QiIvvm9xeyBMm/mv+rlCvBNNpOJnef8oU//tA05q5vNoSvGUNyDoVoWq3zayf/CK
	3ETL9z0O6xPQigL1KSvDFL3eSHcGikuV7BYFggUtg/EmVIGsWmQEM1OXkcRF1ume
	GpWWL8fwdDsPbMhEZnhzXqzC5nPGTuYXO1/EOAH9GMxVqowSnwiui4BIRbwz1BHS
	eUnRZKYWDBKPV1vnR2qjg5RhJ8PQ+GSenAxYMvpON1z09vPt1KwjpTdyI9WaDtVd
	qtAQw3oO8PlvylR0t8935vWJNIEuJQTyCo+9fiU0dv23l5ONSnApGHKyVVKEGR9B
	lvu26Q==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavrssa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:02:13 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-48f0c5d20c6so5515938b6e.2
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 06:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783947733; x=1784552533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MsWDKH/w5P6MtO/VNux/FoMTI22L7P5oBEgCNW8qbYk=;
        b=E/o7DbTOOVfBovhcypRhgR++kaTjc7AVZU7VE1aIv1SnZ92fx3qwTygIT58GJpjUmq
         EWM1qInGYG7MVvLTB4NalOghhcWFqZL26hAhJscOu3htqViGaWRpQAX8xLwHZWUi2fp3
         hmbVuP4/XdXwc/EXx8kyMueGvB95H0LQnCxlWqUUklnuoiLYzVS+oj+HhsJkArtX82kb
         /YVT2nhgw3imCSKG7PXHT+ASBx5TDiwSfR17XuHyRCVCtrR2BYFZgQbuxfYx1QYHAJi/
         12wZfG4moPRuSOxiM+0KfSxedd4Am40iqxFFRVqM05VJ4N/UZd0prggyvcH3D7ww5GqL
         xitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947733; x=1784552533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MsWDKH/w5P6MtO/VNux/FoMTI22L7P5oBEgCNW8qbYk=;
        b=Yu55wtCvggLMpIIzNBATDCf6xbWKGNAqzSw9CD6AJVNI9vgPtlxkWDUiT49ApwcMid
         +gH+iq705meUGnmatRBnVHzIocWQISpqrrAOkc4WQGJptzBRuWsDzMmzNWqwWiA/SEmx
         tOe8Ym9La64hAn8AEc4YLHIzsxu2qQPRNpT+yrcaXDoU9MTWmPji8mIJV1A+Yr1F6taX
         wTBWCBFYKoszDAHfTTVdGf0BUutfPQucr238WzwxrC0sc/uyiQaCsucnQv+cCSoMhbWj
         C7VYHmF29++XgG8oe7OS0SGypWyNZt/6zTz5vjQCkmzoYw1SLL/388c23H30fcFRglX5
         x1FQ==
X-Gm-Message-State: AOJu0YzF3IiMPTv70q1TTn1fyMi8phoyuprheLio6juYcpMner8DQgeX
	7oXumYAqVB3U0u7CO34jPiVHpRiQvF44qTsXsaJz67qXc4zYzPGuc/QF3Jq2tqE9xk0VfdtBN0s
	H9FkqESjO849sx4OnOTWzE6UHH8sjaj58GJXYQ7aET1HMyaRYaeDPDhDBPwzdCbA=
X-Gm-Gg: AfdE7clQGUrx5nBAJeZFITObdoCetx5PRbgQeDg3KIABQomYfHvE73T5QxEYzPAy/Im
	m+ghS7yU73o+M1gvB6U5mGD8+Rs5ZBbTWJK5ZtOFHDH2SxmiA8fiQlPEP7oljDIFSP1Mu02NVrX
	xS7cf2E3jmokzrGrySpclnTMUydlUME8+VAQciP2FoaPWoPLCFV2uKzDkN9FxgyYzIe1yAQWlW9
	KuCD7TeV2JWHee+NBYvEtT3e35Rs0fL0WDJ1UfSqxBDgf9vxHr7rNjKczCJBbf4nWjWBseQohwV
	woNjujK6KkO3yo8pRv5xt7l5KZlV84sHA6BE4/wKbjuMRR8Dsck3mDFL3IuJ1knChxW25Cq/0Ei
	Z4QI8ooOC
X-Received: by 2002:a05:6820:200d:b0:6a3:94bc:bdcf with SMTP id 006d021491bc7-6a39a72fb8amr5197010eaf.57.1783947732991;
        Mon, 13 Jul 2026 06:02:12 -0700 (PDT)
X-Received: by 2002:a05:6820:200d:b0:6a3:94bc:bdcf with SMTP id 006d021491bc7-6a39a72fb8amr5196960eaf.57.1783947732495;
        Mon, 13 Jul 2026 06:02:12 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm306129725e9.2.2026.07.13.06.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:02:10 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:01:15 +0200
Subject: [PATCH v21 14/14] crypto: qce - Communicate the base physical
 address to the dmaengine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-qcom-qce-cmd-descr-v21-14-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1859;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=xewtmBe7Tjse/Oov1uLM7I+VZpNX0SB8ljw+4HhCUeA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVOGhfrH2NKXSF17KSmqZSYmJCy4/yZakaynWt
 vvKhTmcPlCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalThoQAKCRAFnS7L/zaE
 w4OvEAC6nTAxezYrhc+HKbKJEUbU9SmhCNsd6nEk+cW/LBcJ4dP7CB7TvqbWxccqG/JN/L7HKcZ
 BSIWDFlfruG4HGl4gtYo0dE7OeePRr1k+klnQp4lQkg8aPtlC93WmZOAR0xYFfRgKsEJ9VJkjW8
 tNP7UB6Y4uls2OHbjBWziBzTIqB/ooWP1jYM3oS2scHsjnHbx1p00LOdVUta7jH51XAUeKKamfq
 KYeB+s7GkLJ5cVFjlocnjkOuvcalhZbZhfBugjGCzJQ+g+bH7HwAOwqonKJLYtXo5780qe0fed6
 68A2iXZTVurWhhxp+JS1OOZxO+NahMqrzCR2mrLsHwt26rR3qnTfgoak1ZBHtiuy2uKxuOHXj4i
 cgA4nlJxxHJ96b+RLkQ1zKiZoOuN4gXp2Bj3tbkl9+x4Z+BgV1tv+8aJwaJ4OXErmZ/MdemXkAN
 UqTvYK3VKHsq+8I0AN3t6vm0b/+a78X6IpxTSP0B+GLupECFXVO57OeHO9tRI5BC/S2C/+5Tq9+
 O2KGMVfcN1RUAKPYXu4ndc+2tfbpGkk7wqWVf4vUqXP5iqWLIsj3fldX8ZbErizdigVTaTqILbB
 SpZEtBHelPypXOfqmyKM8eQec40XcEesHJlo+o8wYxXoU+WO6deS3cwQKOV649qF+vIVVx9QtTZ
 zhP7w75muXabpzw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: aECUHdjZiYaOC_Hb-zd24piOQVt-oRK5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfXzeMYymQ+SV/8
 NL6LdmNZKQE/zl/JpMZZjmMT0CnZpRTvGbUwwaW7KUaKyIxHBCKgBCsUSKWYdWwU7UAgNG38cts
 n76xGBSZLCJVX7+RaA9HAuFXvTz6lEJ6YZV5IiLlz+JXOtKPoOaIdzrsUW0mQu2ojWN28YVr/kB
 JtUnah/gbr2Nm8gdiAaAXlgKtd78VPTiv7/XhRw37ShXF4Q7/pwKHMqlF3XXEjJzhk3kX+OEMG7
 p/XNzkQ5Lc95lDCpW0nvIbr0iNz2vc5DiEpktt0nD3eVFTY2x0t29GpIHbjJFWnKuQYuljk8l8Z
 YihJPehDi8YMojkixVNfDkXRyD4IljKVEWMsr2hvOAZIx2+aMNgrtu7BmV3NRwLjEVPBNiRb5ur
 yPu0vt8WpddgX0CJVDfh6qfnbJEZ2E6aLIf0Yc06lkuvAp3gc/425V1QnURSvIH5qQT+kcn32FV
 5PKby+GKySfFZZ302Qg==
X-Proofpoint-ORIG-GUID: aECUHdjZiYaOC_Hb-zd24piOQVt-oRK5
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a54e1d5 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TFgmKHP77OfOvYwKDSoA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX9fwiLh6Ns/dw
 nsI+CZhoDWm1aPLsIuD4ypu6eBNi0CzlHEZQ5x+ft5LHdGxKo6qHs0yry3DD8zzWVDHI8AFgZrQ
 G13uveNJDzh1QR9wwoFWwdDEeP9dkkk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12389-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A10FD74B58F

In order to communicate to the BAM DMA engine which address should be
used as a scratchpad for dummy writes related to BAM pipe locking,
fill out and attach the provided metadata struct to the descriptor.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 1b43c56503334154be4b8000e5a9330b2005cb64..6410f8dc5bcf517223c768a3e8f87af245076c84 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -11,6 +11,7 @@
 
 #include "core.h"
 #include "dma.h"
+#include "regs-v5.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 #define QCE_BAM_CMD_SGL_SIZE		128
@@ -41,6 +42,10 @@ void qce_clear_bam_transaction(struct qce_device *qce)
 
 int qce_submit_cmd_desc(struct qce_device *qce)
 {
+	struct bam_desc_metadata meta = {
+		.scratchpad_addr = qce->base_phys + REG_VERSION,
+		.direction = DMA_MEM_TO_DEV,
+	};
 	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
 	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
 	struct dma_async_tx_descriptor *dma_desc;
@@ -60,15 +65,21 @@ int qce_submit_cmd_desc(struct qce_device *qce)
 		goto err_unmap_sg;
 	}
 
+	ret = dmaengine_desc_attach_metadata(dma_desc, &meta, sizeof(meta));
+	if (ret)
+		goto err_free_desc;
+
 	qce_desc->dma_desc = dma_desc;
 	cookie = dmaengine_submit(qce_desc->dma_desc);
 
 	ret = dma_submit_error(cookie);
 	if (ret)
-		goto err_unmap_sg;
+		goto err_free_desc;
 
 	return 0;
 
+err_free_desc:
+	dmaengine_desc_free(dma_desc);
 err_unmap_sg:
 	dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEVICE);
 	return ret;

-- 
2.47.3


