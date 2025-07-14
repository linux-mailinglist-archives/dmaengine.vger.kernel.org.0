Return-Path: <dmaengine+bounces-5809-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D42BAB04C6E
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 01:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F3C4A6891
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 23:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03657279354;
	Mon, 14 Jul 2025 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e4zaRps/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51816277C8C
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536331; cv=none; b=sBBUbWWsqwDz/G8nYKN6zDRYKfjeIO8d5awV99i1otRY169qI5kMk5iUfgmLDtxm3/Oz61mf833cSs4H+hQuuStCoCQv1s4+PuF7wRqzSt2XCfv5XRBQmtT3NwGfcJs3H7ZY36kA95eSZHmzd6Uplk7VebhOQMnjt5bUnjrjphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536331; c=relaxed/simple;
	bh=BLc/nG6tbTXqBWHXJq4nAE9fz1qrAgmKgywiVncJEsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbrYHdAl1X3MB5oPqj+jzGsRmLYBgsf/9RY8Rtz8KpvMjiAehL4WSvUchcvIbqW/Z6SnXS9oGDtUbocc5oyr5LJikZ29HHF5RTEPM1hwnYSEIFyCXnHdWk4ga/lm87/EpSv/mSD1twN5KHfKutzRk1yZkmbQ5M7Be6jl/cdWvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e4zaRps/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGS4vh028191
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 23:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wn0uaTpQJ5msTA4q2mSIBqQxq96F8xnwcsNT4npFJ10=; b=e4zaRps/oaXdJY+l
	UdQ8DEc0Nne1nK1lwtaLfJAWHqyiLQziUU3CzDFUCkUNeWV8JnAqLF4ZqflmU+qO
	IaCyiN56c5pDiAQOpJ9+b1AfDTRlfBvVfWpbwY4pCP7ODxRyQwipwVImtiZyO5Zq
	u1YEOXKa37KH6sh1j/GqAfCY8nztz+Om9WIHf6FDuC7FPCXsgZo6i3zcB6Z7X9e6
	T4s9AwHPkBTS9WDnUgqpGgWpprpKj9V+ypnQ0HV7+q4MgprRJMUwYBkd+zMuSwgG
	+3J1azNHufa9RQ/26fQCJmsfd6flX7m+fE3a6H1KmT5/jvGkrb+aWNHeMwONjcg8
	7N0xIQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drgwf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 23:38:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab77393308so4076031cf.0
        for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 16:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752536328; x=1753141128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wn0uaTpQJ5msTA4q2mSIBqQxq96F8xnwcsNT4npFJ10=;
        b=X7u3Nin8PbaIgqLrQDD6vKBTgcnnG8QttnpVsOEY0djVSDgb+z5SCGGJJ0o8x88Upk
         hxeb49peSozasL9IcUO0SuHoZHnyNDY5eAQq5SCPMQ3lj4e2ExDm/5soIXzDNWc0Gtf5
         nQmrI53DzSXEQogY/kwmqBVpQNZybJtWM6PX9deXlUUGbAz5wRpBqIlM9d2B+uogwN9g
         euidkhCbLGOV3sjYW1bSdI9rszbLN5bT98pez7xF+fv0wTZ2mO3mAz/X5B1zIB44EG8d
         jX136qoEQv5m2oZeYSeVkg5aPb2Pb3KxI7FyASVWQuJB2VNWUKxdDAJgtEHdhr4JFYu3
         6y1w==
X-Forwarded-Encrypted: i=1; AJvYcCV8L7v6KIW/9N3JDGqPg+AJQMsyicE/d8Xz0xVP51+BDeLFDvHF4cooThWeiLiBF9gSAMsm7kqvX4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgbgE96J8chi10Gt+YFBstiU/DU9JsgLRO5JHMXUwi+G7g4xoy
	Ut0AvLxEtQ7Q+x5Ak+LP78yLJBKAHYJcwE5gfI6x+di9PmsBE9LocW7x9xNn5FC1fUKdr6iA2Hq
	SdsyITCfw1qSyI6a33JC6ijLnyrTNsJKdf0BGGTGPq3fyKLn7C/MJ7XQx0Q/kcTI=
X-Gm-Gg: ASbGncsIBrLQpLRlDy1Qlefgjl0lzxM+WTTmf4JPH1x0tYZjQ5+D6dSw25WBr6x+dKW
	+P/Na+B+pRUrUwAqQORqFf03jDOkgoiqudXp/8RtQ+ayuTsdnlUtylULqL/n71z37CqsiTaEiNv
	VslGWBP4V8PVEN0v/2PapY0o/HSumE/xBTSOE3829PGchmjxZHlhDNwOPhZB9xHVhzA/0gChhD3
	kpiJakHGDBw1moRgXQRgds9CXbySKTkC+SXHKTCAICEV7UlPfvkvPY8AJJrSciCGu8Up1KBVqeF
	30HXwCuP9G6JDJPQZjDrIUaXHjv/ldFg3ddSKlJoiO1GuNAr6Q++s4kx0COJa/OKR6km+bicqa0
	R2qOyjOi3Vu+SBOWgIhTy
X-Received: by 2002:a05:620a:261e:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7dde704afd4mr776223785a.0.1752536327966;
        Mon, 14 Jul 2025 16:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6vgTUK9cbHU9/fu7xu5UC9MgWnhvrvZKB6D6M0lFax9GG6pjPJlqFz9LcPg7nXnR+3oUNPg==
X-Received: by 2002:a05:620a:261e:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7dde704afd4mr776220285a.0.1752536327341;
        Mon, 14 Jul 2025 16:38:47 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8316b60sm887600966b.184.2025.07.14.16.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 16:38:46 -0700 (PDT)
Message-ID: <c379aad4-96f6-4134-8b90-0f1eec8001a3@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 01:38:41 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Various dt-bindings for SM7635 and The Fairphone
 (Gen. 6) addition
To: Artur Weber <aweber.kernel@gmail.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
 <aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com>
 <ee0d148e-71cd-4136-b3cb-145566abdfbe@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ee0d148e-71cd-4136-b3cb-145566abdfbe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: As-HkFxC7nCz8NZeY8-bsuj80Nb3tFkb
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=68759509 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=ySytLBbe-S1-HUGBodAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: As-HkFxC7nCz8NZeY8-bsuj80Nb3tFkb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE2NyBTYWx0ZWRfX+ms9g+2y2EcV
 nBUw6x8m5q53Fq2nvxopsQvK5jKUcTdLQPhS3/HueXVSMbd+1PotdTnr7efVU3ciGQCBaaGK6WQ
 lhf+cFKWE7w0t+eqxricsWovJFMPCLVfyRxyekuyqsteirZmhJ4SdU1xVeYEboxLvv91oPAmRpp
 y0AC7gSIMDodWmPQ9IllLUgFG8zk6arjX4axIj8DZsjliusBi5MfXEykEm3IDzHmtBkk1STdZ7+
 w+1T4lAvIpcZ0M2IJ9Qu3cjqKfjrRn2bxTZZs9E92fcnkHqUvtq7R90yoMEGnloE587+k1YzR61
 yKWwhDxWRqPub+IR5Mu4lYydWrYv5q8TuvnCc+LUU7MZguLLvtqxzjaTLBb7+EenObBOXUhDitM
 2txzsdb+8pjvWEhg1FkEunm4XhsqtI2buaUJuNmWuJTdcCtuscSB7BgJb2MWgv+aCWIgoChZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140167

On 7/14/25 8:13 AM, Artur Weber wrote:
> On 6/30/25 23:59, Bjorn Andersson wrote:
>> On Wed, Jun 25, 2025 at 11:22:55AM +0200, Luca Weiss wrote:
>>> Document various bits of the SM7635 SoC in the dt-bindings, which don't
>>> really need any other changes.
>>>
>>> Then we can add the dtsi for the SM7635 SoC and finally add a dts for
>>> the newly announced The Fairphone (Gen. 6) smartphone.
>>>
>>> Dependencies:
>>> * The dt-bindings should not have any dependencies on any other patches.
>>> * The qcom dts bits depend on most other SM7635 patchsets I have sent in
>>>    conjuction with this one. The exact ones are specified in the b4 deps.
>>>
>>
>> Very nice to see the various patches for this platform on LKML!
>>
>>
>> Can you please use the name "milos" in compatibles and filenames instead
>> of sm7635.
> Hi, small half-related question - does this mean that future Qualcomm
> SoC additions should use the codename for compatibles instead of the
> model number as well?
> 
> I was working on SM7435 (parrot) patches a while back; when I get around
> to submitting those, will I have to use "parrot" or "sm7435" in the
> compatibles?

If possible, please rename it to "netrani".

Konrad

