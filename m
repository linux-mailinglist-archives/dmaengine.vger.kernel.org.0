Return-Path: <dmaengine+bounces-10617-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGg8OIqrDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10617-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:51:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A39A59FAEB
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A58F301CEAC
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E63394463;
	Thu, 21 May 2026 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B1vg3W/e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fpy8BxmF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46739349CD7
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346313; cv=none; b=dct95J3bdSrxq6gKEgSmay/+5f+usWBjPvxNmdLWiWzGPocEy9NvvjkDCXsVmz4Qtmjp4iNjFXln3ZiU7bK9ULus4sT+vj2al1JKZdPdwDRuJ6DSieQKjNI+gd9kSawtGm1YppgWl2IiK1+rB96HmNIMaU0qpb4Oe4Vmeq5Mkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346313; c=relaxed/simple;
	bh=OzXvlTwqyg/LORhSSsvxHKnz+VzK+OsN50SGeyyrFmo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AHvJUwOKIgEfjbKbwVyC8J1nioDnGTSRPPR3vPS6ip+XbPfty6OSlVIK4ssZdXS2YKszWRi63U595ZkLYvDhut/muBpM+ywYXk2ttfW9KKM1Xg9kpxyAdD+RYZUL1nZVhDdqxq6X8HFiBoO3HaeTboFikx1oN3BIEl5iZlK/2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B1vg3W/e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fpy8BxmF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6nOKd3680282
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ipaFgG3ogON0geuVOtzTG/KiPSvXW3QMvF4djvkApMQ=; b=B1vg3W/euwWpmXT0
	mzK/ivX/06i+rfYeWpY4Q3W0jG7eYYXGdcOb/6CtlDz2zAtjyAC76ywiKXwQ2qGP
	G/FwwUPBgqXK4PMmDABwSM/Sa3l85HjCfxz7GMhau5d9oubwkrLSh+meSJV4yk+V
	btNs5mLaK9MwW/pJiKawRCMYxytvUy2+gDVCXG7Q8j+Jv0FrHqpBjNrUgZLlYp02
	ex7sRnqXkCmwpHaMe13QVtppYiW2fASuriagul9HYgHOCXH351shb3fu0Vr4fC8x
	ggnd0nZp3NRv8z88HNpz4Sn3CRz73zpPTek9G9BfX1t7/0USEF4b8/SnK/k4BjNa
	cYEfgw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j3j9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:51:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8353b042152so7753170b3a.3
        for <dmaengine@vger.kernel.org>; Wed, 20 May 2026 23:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779346309; x=1779951109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ipaFgG3ogON0geuVOtzTG/KiPSvXW3QMvF4djvkApMQ=;
        b=fpy8BxmF9If6zIOEIy9ghZXjRphg/WBy4FITj5ivZgX0Rsx7dybL3GH2xf5811tnBZ
         RNIbK7u9q4LSpEllAWoNO4iNqKoN4Sum8l86pYwECo521+jsHMXUkZdQqyOWP5Ohkyws
         ZFcRgJFyOJ0+k4p1na7qSo/iCnWTIlh1xAL8EXUu8Znfy2Ivg5ArwiJM220X/lElH9/y
         568xquEDqj39P9dJ1kNCPh9+34OrnJEXxbfQMAwn663kIR6tGhs0SKt8Z2wTy9R0ofrg
         aBC68X/tkCR9ZmeLoA4cZjtl1kYZoMh4GcANXEJsU+LRlD9ZU6KlI7lEcSZMoiwQdygx
         F6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779346309; x=1779951109;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipaFgG3ogON0geuVOtzTG/KiPSvXW3QMvF4djvkApMQ=;
        b=h+AMt26TVJkZNozcooRhxBb8QPITFUy7rUCKgvh2mGJTQH3U1O1E6tMvcxuzHPh6A2
         +U0qdgJ+ZhZpfkefChfKZJy+yK7+qR0OevP9aFULq84pQflp4I3IOcgDJPfbuH0Kb7gd
         WvRQlaCxkDIVU2xDV8Gx1b9f8LrM6oPJyf/IPU7Oyozx7ObUzLTy0nHurV2piAmNVvIp
         92VHhQCI91Nphf+UqNZho+hXR8dXjUrutJCEkl77v67pHpMBFBXDsZ6716S0+b7kqGwR
         0vCMXr/K2yld/1A1RbGmC2p9jjM7mYEovWP/gJZIV2SdVB4qjYjpW3E5xJDz5GIhDSew
         3qwA==
X-Forwarded-Encrypted: i=1; AFNElJ+SkfxdcRus+YyhvfN9KkRSVpJC/ycS5eLFY9cFx7lDmnbhsBfT18FAdp7Bp/yYuCsaCLMlaWU+O/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+pi86XlMDQlnNpf39uEULbrR0uSZhcDHO6WKxWQ2053D5PT9
	solWTStTths0Ocs96vGVKLxgrjngw7hs1ym7dnyKF8fBKkGZ2kCrDQrBPTaTYPFz1ZB5mkhuUc3
	307su4o4HPs6O/p7a2yoQ4WjsbcseI2f3isWl/YJBobqLM/ag/3Y3/eMnaRqwF/I=
X-Gm-Gg: Acq92OEvD/+b3SWp8D1xjdk9g+7vpHp0PWrKLVXsfG36SbT5JwsHWNuc7ZPz956WRLa
	FiXJwPe+XxGEUm8jj7DVqw3sLkbGuG2DlDUEFrKuT/iw6eizdbOym4lCkaLPysj0JEaVNwu7/1F
	/lSWN+oKHhUcGIwfvMRT3WnoSkFiYYXt9paiM6sxuYpU0zkZTs4tDci8O2/QKtO5mTElMCVXB0e
	LyYlrsE1TWRFlDfReHBN/jXxKGsWdZn50y+Tz0tGbMxK8r2d5LMDo6xk++J6wCw3JcRGm03DwaW
	lFH7pi+y/xRKudD4hTlF5Tl21i/OrBdPSq5HsOu8t7nolgQpKDV/iiFsnx4O8OKl1wDOku/5D07
	zHCpc+kS8y4YCc1UCCyDx4NBflQUUnbw3szSq9xtga3fIBc70mVrJ5WDUn0AtFA==
X-Received: by 2002:a05:6a00:845:b0:835:6d99:3f94 with SMTP id d2e1a72fcca58-8414adf542bmr1746464b3a.25.1779346309538;
        Wed, 20 May 2026 23:51:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:845:b0:835:6d99:3f94 with SMTP id d2e1a72fcca58-8414adf542bmr1746442b3a.25.1779346309052;
        Wed, 20 May 2026 23:51:49 -0700 (PDT)
Received: from [10.92.163.96] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e59ea9sm232016b3a.61.2026.05.20.23.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 23:51:48 -0700 (PDT)
Message-ID: <d4d35e17-84fa-4c95-9bfb-abfd25ea7f4a@oss.qualcomm.com>
Date: Thu, 21 May 2026 12:21:41 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] Add support for qcrypto on shikra
To: Eric Biggers <ebiggers@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260514194735.GA1939213@google.com>
Content-Language: en-US
In-Reply-To: <20260514194735.GA1939213@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0eab86 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1cRb9DtoxWFOFH21OVAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: EuaA8q-bbWO0Xp8S2YsO1-AfIWk-93Bw
X-Proofpoint-ORIG-GUID: EuaA8q-bbWO0Xp8S2YsO1-AfIWk-93Bw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA2NSBTYWx0ZWRfX30QLzGoPs0av
 rjaZa5nS71uZYtvMPGqd+5UH4XlGxCpPVvjvDDE5mkiDJ/RNz9ObjDdqmfEABzq9Tb+vuygQS10
 2XMKnFRyd1DzdXdDKXK0Uh8sEw+eDbpgZEBje16ichK5zIEdr+ssVgIaKu1rxHbsnHmttXjnWEf
 /PMf/pUy9zGKsBA6mndAIN8EKrXWj/oAt0oP9QEApzIuE3S4z8gBMG95X0ZGDSSInvMTi8N0PIL
 XuEhi3ibHCRkVAm3ZQPAMhYPTIP9SGR28uWeSavL4d2VpxSiBCEpmd9YegKBhFIupu/nkZFBFBz
 g0d0KUMjAEbThjzZ2rLssZihEtfclRGY+Sr3p37rC/1Vq9tRAbSI7RL7/Tvw5KOuuXhEORh6QtT
 fepnEqxi1eoXxdOj3h483+Xcf9bB+xN2eRassqNOa4+AGr7fuh6Jv0noQXwc4y9teD6GSxajZu+
 j5Yci8hkoZimiAm+WiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210065
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10617-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8A39A59FAEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15-05-2026 01:17, Eric Biggers wrote:
> On Fri, May 15, 2026 at 12:53:35AM +0530, Kuldeep Singh wrote:
>> Add qcrypto and cryptobam DT nodes for enabling qcrypto on kaanapali.
>> Shikra bam dma supports 7 iommus so update dt-bindings accordingly.
>>
>> The patchset depends on below. There's recursive dependency so referred
>> to base DT patch here.
>> - https://lore.kernel.org/all/20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com/
>>
>> Validations:
>> - make ARCH=arm64 DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml dt_binding_check
>> - make ARCH=arm64 qcom/shikra-cqs-evk.dtb CHECK_DTBS=1 DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> - cryptobam and crypto driver probe
>> - kcapi test
>>
>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> 
> What specific kernel features would this be useful for, and what
> specific performance improvements are you seeing with those features?

I hope you mean 7 iommu entries.

Please note, shikra is an old platform and differs with latest platforms
like kaanapali in terms of iommus#.
Kaanapali is optimised(in terms of iommus#) as same pipe index/sid i.e
4/5 can be used for general purpose or for any other usecase like
DRM/HDCP etc.
Whereas for shikra, there's dedicated iommu entry for each usecase and
same pipe index/sid cannot be used for other usecases.

The performance will be be effectively similar.

-- 
Regards
Kuldeep

