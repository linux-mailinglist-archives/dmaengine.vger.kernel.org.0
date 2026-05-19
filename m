Return-Path: <dmaengine+bounces-10529-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOxaCk0nDGrLXgUAu9opvQ
	(envelope-from <dmaengine+bounces-10529-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 11:03:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DBC57AD1F
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEE083078ADC
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A253E120D;
	Tue, 19 May 2026 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQHgc4Wp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c/ioRg+T"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C3F3EFD34
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180931; cv=none; b=ZyFSL9fIh1JtewOEmnckmAM+dcpUh1Z5/lV7yIKfI22N3PgfklanIUJS9TMkVtGJ3UBxWJLGcDohKfOCDTp+Pu0uqHLCV4rTF0gkthAFKYFVENh4FAj0WByCGI9tJ0j4yLFO4SOIDmN6gNE5d48qE4OeAOBxTkYvKxEfScPHqqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180931; c=relaxed/simple;
	bh=Pvg0y4IvYgyRyjgGSyPm0Vv3Ghs2hJveIaCUm/K4Qg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ND0Zg8DWOqvORdr8HEbcrQhWysj+/BeKpH5NNaSvL7t6k+IPH9BiV+Ao12smIsYaamAQ70K9tbhNTKku/3l3Qw7cV/fu0g2hfhbWuGFrcyithMPg6T350oz251M7pM2GurtjyLzjxwfvZ/YLoXAoNH7ivchOVLYkyCEYsbiv1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQHgc4Wp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c/ioRg+T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J7lXWD1146406
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 08:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LQ+0FnEJugjYxtjlpuNz1AMACB0wuPR4vp/JFTyrtdI=; b=TQHgc4Wpx28xJfm+
	nTuFt5EYDOkev0Rxiioh2PUjtKDIW8liibfSjiadElGJBgU/PUWFYxG5xT0iuTDY
	iH2zfeM4FDrfwhm4nHwhO8tJyPC1BdkiadNVp3mB919J0I+GOy7Y8aRAl5Cou+/w
	PtIIHcS8flFX7orG/S/qzdxsAhL/KGNBoYSepgklMJk6IM2jdJZ7KBztJ+K1HzAf
	wmolCJ1Zx9ctgAgA6EP+B6KEjYCXWEZSau0xNxGqjFWHnnvbd82/f4gGu+OJKEu3
	6Qg+f9iigDyhZr+BFRgY6mJ191wIddKgVSehNNz9bizLwNx/AIUK3qUn33Le/1FP
	Bl+Ulg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8e7ehky3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 08:55:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba3245a43dso35160115ad.0
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779180929; x=1779785729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQ+0FnEJugjYxtjlpuNz1AMACB0wuPR4vp/JFTyrtdI=;
        b=c/ioRg+T4qMGG8EjcfxkWmI9ZM3HKGC6VCUZQSzb7cWSs6ZagDNTA+IyT6KxHwPrzO
         4BbYbHRyo5pZJN72hft1eabr+XGHJ6Nbet4WZ17dxrW+meHDAClbF8UHoCz051YpST1E
         ihY/+5sACPGWEVbexfKwRCDhmH5qRKLGBo5lSzBdJYfDfRzMST03T9JVuKWYtYTA5kBC
         zs6I+xtctQ9tyzs4JYfGwBRYvnRZkGircjts6/spdKnosroFDR+EURp0hS8lLfL5DWX2
         lIHoTNXf1SWFwdfolwcfJdvxX6pwxMkN/llpgOS9rUTBJeZmGvPHGG3kW+erbjAz6bQf
         fgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779180929; x=1779785729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQ+0FnEJugjYxtjlpuNz1AMACB0wuPR4vp/JFTyrtdI=;
        b=OK5UbIUP8spvaFPkFHesQHhpEMT5ECoKv8V5AIq86KoBS+EyfzC5OsFKcW44MEQy8h
         ZKQlmnW09yx9MwS/00Sj/UpvOMmIRsONTUrInRDO0d3V8k+rnfypwhNQlfkn0ylWOXSc
         4g2zUmxlFrhCas0Tomjh6MmQCb7MOcnB3bNDJ6tBUvntGVW82SOWUo2voKwcAVAxw3DI
         y3mAtk50ZNXDWa4VuYewDJCLXa1YkhPs39Gv9AZCDCJErHKAlj4cPRozcP8azInTVVxe
         yzYxy4di3QSyxqVQBCmh566oEAJ18OccWA3C8eOYEKIgTSvt/KS+wpoA1OFbVD+dZ8EH
         NDqA==
X-Forwarded-Encrypted: i=1; AFNElJ8lXgzZikDAbghGUcCVrMoCKxqcB9OnUXL6AaQC9dDKwYWu6ooHzAkCXmcZMfAsUu33OJ730eJoCSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgOJj0YHuNzl9kVbZPkf+elSFwcFLiSrVZXi371LaFKiG7+xf/
	/8g/W/iMmEskUGCHE3w1V/W1LhuAC+t/WCrk01QdxA3Aw6UKExh8ZU+64bHkhc6ACu1HZvD/UiW
	XRmZSU/T30kvQ9sDLNQKG1OkZjSkd15SsECmYQZPDbOqLlD4+43xDozQseBBEy/c=
X-Gm-Gg: Acq92OFSbk/3Jrel5yvg7qTBTSYWfwSHzEN/T7/qcqHUR6tzpgbMoMrN5wUZ9IVSrQm
	CEQK5L9SzVPYSH+onFdBOH4RCXpi5l2pg+ApvXlE9ppMf8el5sWyYR/BxQh+2f6B7vOsTh7dXpn
	A2i/WpD229BdZSJ8VVz4O7lcXubrJemrnP0nwM6vYqw+f5B059KI7fA1wcLvpfSBdvl4jXyS6rJ
	SVegU9bXUmUidIS9JHtKLiCJ2kWmet74J1ld+DL2dYxbr1mL3zfkWlFO8QXPJ1OsrbfpkSuRRpT
	ne6/klzQjN2Z6JEw0mL7+jpPnB3VIWZMqrinbLyyz4bV9EyUlGXE5ChJWitey5V1xRelquZHUZN
	fpkSkTo/oepHRRFErXJK0+bTsNtBZsrxreumpzVgE+6ma/s/2UN8PQm8H9pr9M+c=
X-Received: by 2002:a17:902:9a94:b0:2b4:65f6:e24a with SMTP id d9443c01a7336-2bd7e7849a3mr126806945ad.4.1779180928755;
        Tue, 19 May 2026 01:55:28 -0700 (PDT)
X-Received: by 2002:a17:902:9a94:b0:2b4:65f6:e24a with SMTP id d9443c01a7336-2bd7e7849a3mr126806705ad.4.1779180928271;
        Tue, 19 May 2026 01:55:28 -0700 (PDT)
Received: from [10.92.176.107] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11d6easm193406485ad.72.2026.05.19.01.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 01:55:27 -0700 (PDT)
Message-ID: <e0a49e4f-08cc-4faa-a7c8-ee7ac14615f1@oss.qualcomm.com>
Date: Tue, 19 May 2026 14:25:20 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: crypto: qcom-qce: Document the Shikra
 crypto engine
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260515-shikra_qcrypto-v1-1-80f07b345c29@oss.qualcomm.com>
 <181abfec-a6f9-49d3-9428-21a169a94246@kernel.org>
 <f40798ef-e066-4814-a26c-729dcdb9f5b1@oss.qualcomm.com>
 <166e09b6-2fd7-450a-b7df-b59b961bdfe2@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <166e09b6-2fd7-450a-b7df-b59b961bdfe2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Rt316imK c=1 sm=1 tr=0 ts=6a0c2581 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=-1BLe5um57GLRqdpntkA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 6rkBw0Wda9lEhvgKavdYgByDol1u0LcO
X-Proofpoint-GUID: 6rkBw0Wda9lEhvgKavdYgByDol1u0LcO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4NyBTYWx0ZWRfX2l4ZcN0H8vfv
 mkBqXmKEbGi65vmSCjoNQ/xiJ+gmhIhidl3qTdQC1Yaxk9cd1tBMI5qdLa8yz9Kdqg7S1+X7L9P
 mt49zql+qtiWGt7JXIbq4QfOQr1WWKHmQYL+6/TDMKIWuwLmzdt4rfsWZbH/GFxq9gyr/gmMqeH
 hMfZ8Yvjaky8Kap/K/H8G+WLljx/R5dT8dApt7PpgQjGu6XCbjstJ6xA86Ne6bwkR7ojgIILJOd
 3Lgaez/cQhqpGsPMJ613qo+ksJRMw94T2+Z5B8k5roU+ugbWHA+pcHMUJ9fKZeNE/IfOVo+aUWE
 Tw+g2PM7P7h/K7jEeShSVDUG1DRCtspi6rlKqR+Qiz81Pc9OwBgA6/j9DZifZgiOaW3+h2Rz81/
 bjRMCwVEKRDoiyKi6KcpaYAwUfekBIravTQL1lvuL7NvP8LvgJwd2HRzau/K71eMVEAMrAVd0nQ
 VIpZh2yIGF9Nfkp9PNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190087
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10529-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,gondor.apana.org.au,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 66DBC57AD1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> No, about proper patch organizing into one paychset instead of sending 5
> different patchsets with oneliners. That's literally the last
> thread/feedback on internal Open source forum chat, so easy to find.

Sure!
I'll align all 3 ssg modules(ice-ufs/emmc, rng and crypto) in one
patchseries for shikra and send together for ease in review.
Will ensure to follow same pattern in upcoming submissions too.

One doubt, there are mostly dts and dt-bindings patches so i think it's
best to organise per module patches together in big patchseries.

Kindly suggest for alternate opinion.

-- 
Regards
Kuldeep


