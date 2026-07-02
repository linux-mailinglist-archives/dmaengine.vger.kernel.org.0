Return-Path: <dmaengine+bounces-11957-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wSAdHYZGRmpaNgsAu9opvQ
	(envelope-from <dmaengine+bounces-11957-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 13:07:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4436F66F3
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 13:07:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=a2hGTebG;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=iYwAYDZ0;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11957-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11957-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF77B3043F92
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D303C76A6;
	Thu,  2 Jul 2026 10:55:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34253C4557
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 10:55:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989756; cv=none; b=eI8sb6PQadNytivFQAsebmdiEM2/9scVO9zxKXch3GN3kZNzwWRT/RwtH2dgLgj81tBFHTefB/b+egOmLpHBuXkV8t9PW665ILWCcWtAvACpSPvogXaZIYjixF4IS9L9/ofIEydtpMuRrj8GMjKIDtlQkjz+BCKkKGUSZ3oz3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989756; c=relaxed/simple;
	bh=/ZzlequwXhlS7LWvnF4LjPV63ziQ+cD3M2ZZ5OvxKnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAPIIyrmPniSMlSQ5xrltIldmPnKZPs+cxXYQ0O7tOi8qBi/sGvfEbWukpHBnJA6A+vf1SNXitq5QrRsVsUrf1nEpEtY/k+0d3cgj2jq0IRcQxRwjMqAQvLg7OsYgEztPgWuVKU/+DkP7/twsFYqCvN0d9WWy1jGJrqcMgD30Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a2hGTebG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iYwAYDZ0; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629nUHA4139572
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 10:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y1ryAiwJl3UQzitsPwkR7CGd+DjhIbqH1QEDSsZ/xoQ=; b=a2hGTebGOPF34xxb
	UhjLMYhe7C++fX47vrTKWSBq+PICLiPz+P8pWN01oDjQM2YxFAtKldwza9BTz8mh
	CYtST+LaUsMAKCTZfdatkDlRKGNolCksgd3We0aKXId0NPoUxselRmnNgej0vlRS
	rLC6yo4Udy4RI0xcmwlqjCyRDNCvfAgvCWLOcdT8tjN3sHAf02YasApZ15j7K7AE
	6ql2Ub5/hm8yM5osiID1vNaTCrjBXBjbtgq4F2oMkxjuxD5AXR50SqCjwFrSBfTJ
	70fX0hS5JuTNk4rMBwo/RC51HZnkcAUaSQp9orNjSiX4nvjPdhv7ZVEooelTY3Ba
	bzHp+A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5npr87q7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 10:55:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c21be5bb4so8356091cf.0
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989754; x=1783594554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1ryAiwJl3UQzitsPwkR7CGd+DjhIbqH1QEDSsZ/xoQ=;
        b=iYwAYDZ0Hnc2OWSmwmko/D345dKyhadKPMys3qyENSbdho0/zaNa0XEsXAVDT5GjLk
         +c6gV/rGlXAKjc0WKd6eZdKEXZ2YScE/J1JPtVA/v2f2FBLGz/P1QpkX1BJm6IxOxAXe
         3zyCW9s/c/9VYIFBbJa3qUoXKWBH8e6NZ3Q2ab73yLYeVVwl8Sc1kVkPTylP1WkSatGX
         2u8PkwSta7oEE+rZxY1eWeuuxDcALIHjPO0IsqaTMgWdgObLHrtzPo8VFxAX0Tx3ITFp
         yoBY2Lm2QyTDvubixdRx+MlMVcyomcy9PP30JRlAk01bj+o9D0XjABt4kOxF6yuCPWkp
         V0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989754; x=1783594554;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1ryAiwJl3UQzitsPwkR7CGd+DjhIbqH1QEDSsZ/xoQ=;
        b=QD2t+jc5/ziZi0n8HVywdTaeB9MeJps2EIDrDZLZHzYwiDzVZunOccatqbpn/EayKJ
         0QZw5hblk5OqwwSFmXAWtO3xUzdvJ2TXsIPFo7PKm76Io2cZgqV3n8bf8Rh8LRphBai8
         PLxPHyvHoyHwvwrgnzTvvXOnh8a2c0YnZJFOEoUI3Fuu3Y9DkE6+inOzuV3eDOriRCwX
         HG6nZNQaxJrogspiud5xZiihumz/EUaJN6Wp2b8wFdaTQkE0gUjCCB+37Nuv97m/B1lb
         lVlQV5/rEe6c2NA8K2rDcmjAvh6ZvLU/1b2Al2TjbC5xApC1yqWPCmu73ipiBUyxecVP
         R1GA==
X-Forwarded-Encrypted: i=1; AFNElJ/hOWo11dIjUlHVu1bv/UhZhySpU/vKdUKjXmLIUKFwawWdkR6BIU9dUaAq9s+z0RCJKHOfemXfD4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaqCSTiyrzVpxFtKd9ChrstwIaFXjwXurd5uU9duk3W/SWX4Il
	hgFu+GDaKsfEv2dBlN+chn+PfNSd0qQKNnc2K1doQ3gXZDLZvELXrC8+Lsaondnu+DFq2LE2Ku+
	vDtfTPhoIzwXSp63soVtiqEEbi6j6pT40HMOzsrHhMOoo8RUuqPobyN1PTBh8zuA=
X-Gm-Gg: AfdE7cnxRGBZkSBHKO75WZuwLwCNAAef0+p4A88ASrlQ0MTrgyGebO2EEbSRvHq5NaZ
	rJkrIS5WF/YPhi8Hwtso1YbU8f9CKX4zveIYUFIdw9PjGmm/n1AcdUHs0eJS2A+iFyXv5sug4Dq
	5xODGmLL1qfOs7uH+YORTMH7VTxxOjagkNkOrLyVfj2i6tSVfuH6W45xaC9L/S8cCNLgdlejLmv
	RjlVC1E82msslgwUIBes01+hzPFLGmiliidjE7aV6WYXofxbOL/3ecXVtUSQtMog+JBm4Se7tLu
	4o1hnTMdN645xl50bYE9Keg6hXkTTq49wedi4nAhAfYasD5MVX0kOhOzn37ew+XyCp9hVdIdU5J
	VaaoaHUteWlLRxudRXSlYDBk+1YkYJS5j9Qk=
X-Received: by 2002:a05:622a:14d1:b0:51c:223:3c57 with SMTP id d75a77b69052e-51c26b41df6mr43962781cf.10.1782989754244;
        Thu, 02 Jul 2026 03:55:54 -0700 (PDT)
X-Received: by 2002:a05:622a:14d1:b0:51c:223:3c57 with SMTP id d75a77b69052e-51c26b41df6mr43962511cf.10.1782989753769;
        Thu, 02 Jul 2026 03:55:53 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698ad118f43sm788110a12.25.2026.07.02.03.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:55:52 -0700 (PDT)
Message-ID: <9c1aab59-14b2-4811-b778-8e96645bd65b@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 12:55:49 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Anurag Pateriya <apateriy@qti.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-11-f911ac92720c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-11-f911ac92720c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CzqLvgPflP8OSmQwCzKfLQjBeODmFVv0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfX0mX1nwgdrzNd
 akBoQQfsIaTuaJ7d2gXeLcd5r2J8eneXaIUCxLCd+MX5UbApVCe9VWdVvHGAU3Ly0E9Sld/4nKi
 3h0bf3IxN1q08IKtHARdhHwG6ZTvpi4=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a4643bb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=t9bxL2sBmI2IUrh-d9IA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: CzqLvgPflP8OSmQwCzKfLQjBeODmFVv0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfXzJf6874yMLd4
 GGxbMdosvOtGu9wsaf2xYONAVx1yLnVe3Sh/+scY/Rhmpw+o58qXhVnu5u1gQxq7e1qvYZ6tLlx
 wlPxuDwiXBVUS+1JeijTe8PLD5T395P9e8XlbEjY2g0fkRhagsH100g0nvSLXAtPP/R25SG677i
 a3wEYusyQ0mTQtVyC9mVSAN95L2GO3vhXWZbCTIC6pqk6+Qly0MwNBFtCJR6hAx73p3EUZv7WJu
 1Nk5okpfmATMpNgVQGAqv9QjAzoJKKQyoKcXHLrIxhwHGq7pHdUtG2TQX6ta+nfy57Fk9cTaO0r
 hXuZvWsYJDgGiQFn1t2f/uLCYkOw9ak+po571Dk+rCP3/s/mDSyXhxaTxmcCmgWf70kmfhuM8w7
 Ae8jcxIc5wyvuQi1812iAjTogujb8oaYSQwk+23PwtAGQXGzSTCzn8lg6+X3eFdvxWDa35nBnEw
 IAzM2C1e5eA9ioQugiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020113
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11957-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:apateriy@qti.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD4436F66F3

On 7/2/26 11:50 AM, Komal Bajaj wrote:
> Add gpio-reserved-ranges property to the tlmm node for all three
> Shikra EVK variants (CQM, CQS, IQS) to mark GPIOs used by the
> SoC internally and not available for general use.

These are generally added to prevent non-secure access upon TLMM
probe, i.e. the board won't boot if some of them are not protected.

I assume the proposed set contains both ones that are _absolutely
forbidden_ for Linux to touch, but also ones that are dedicated to
some specific purpose that Linux _shouldn't_ touch.

Please add comments, like in glymur-crd.dtsi:

        gpio-reserved-ranges = <4 4>, /* EC TZ Secure I3C */
                               <10 2>, /* OOB UART */
                               <44 4>; /* Security SPI (TPM) */

explaining what these pins are.

If any of them are boot-critical, squash this into the introductory
change

Konrad

