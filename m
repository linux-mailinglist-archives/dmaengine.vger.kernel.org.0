Return-Path: <dmaengine+bounces-9770-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HAtJR6xy2kpKAYAu9opvQ
	(envelope-from <dmaengine+bounces-9770-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:33:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 380E5368D49
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3C933034493
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E763E0C46;
	Tue, 31 Mar 2026 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F0VQe1bu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C3E3DEAC0;
	Tue, 31 Mar 2026 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956743; cv=none; b=OsfkQibF8QGf2WPFdSRUQJrFz8inSPzp/TLNdIUN3NCxKwl/oO5E7GFnxRrNZyUXcGvo+5ctfmuGpzKLqSxSJONXRawOgZfZXoFZH/y8kHdZ0PSxlis8H/tIbjK6nL4zMaRXAsKvv3bQJsO5CVDpLyG66To9v5XFrrRXtK9nLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956743; c=relaxed/simple;
	bh=04FZtNr7BRjVpHi2U9tmE2a2V9/1Fj7tK61Q5Agob1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XppRj/YClPYQgHOYDiL3UF1nHfJpXGCfmq9To9rHCaPOAXoddQWPkDmSZ1uqn/Z6LNEU17oB4zqHpkcUmP3t0mHeLWlM0D+rNw64hCTqXQILSdb0dTR/VL5hcl7BvgBFHGZr9Wkq2flM00LMQ14o5fJRg3vI0m2g8wJDwOmNKR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F0VQe1bu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VB4qrU1091985;
	Tue, 31 Mar 2026 11:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/BsL8nqFa39gHZBYARFSs90fkPIO/cSXWFW5JLe4r2w=; b=F0VQe1buqAjzijuy
	au75RXtF+n49Z+5PRTOFKyR7IIGKRUxBs+6BPPbByoXFimWHmt5/atP2dGE93uTf
	uEMSjYtmTwG6grk+4sldOUvk4ePMUpexm68I1eIHz158SYqNnhEg64kS7VOZHxgd
	g67ENtJoFI1hx1s4kTqYT42rZWVSiYc2dxHSBWAXTLCDsRN3yaBKuEni6ezhivqE
	sb43etRnT95OHtz/QcFiqNFNiryIhSjtsdC0UHfGVdTGPRUQtfWS85ZKz82Yb0AL
	iIYjSGJzH/bhOKOqz5mc0771qhGCpLTzXnP+Oshc/RQzUg7Ywm9X/nM7wL3DZH1q
	UpDgbA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7trd4gga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:32:11 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTPS id 62VBWBtD010888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:32:11 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 04:32:05 -0700
Message-ID: <d3c4ea34-1c49-417b-8fdf-212ad77e3545@quicinc.com>
Date: Tue, 31 Mar 2026 17:02:02 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] dt-bindindgs: i2c: qcom,i2c-geni: Document shared
 flag
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio
	<konradybcio@gmail.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>,
        <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <andi.shyti@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <devicetree@vger.kernel.org>, <vkoul@kernel.org>,
        <linux@treblig.org>, <dan.carpenter@linaro.org>, <Frank.Li@nxp.com>,
        <konradybcio@kernel.org>, <bryan.odonoghue@linaro.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <quic_vdadhani@quicinc.com>
References: <fc33c4ed-32e5-46cc-87d6-921f2e58b4ff@kernel.org>
 <75f2cc08-e3ab-41fb-aa94-22963c4ffd82@quicinc.com>
 <904ae8ea-d970-4b4b-a30a-cd1b65296a9b@kernel.org>
 <da2ba3df-eb47-4b55-a0c9-e038a3b9da30@quicinc.com>
 <a7186553-d8f6-46d4-88da-d042a4a340e2@oss.qualcomm.com>
 <e9fb294b-b6b8-4034-84c9-a25b83321399@kernel.org>
 <835ac8c6-3fbb-4a0d-aa07-716d1c8aad7c@gmail.com>
 <f1fa2bde-95ce-45e9-ad2d-f1d82ec6303c@kernel.org>
 <8b33f935-04a9-48df-8ea1-f6b98efecb9d@kernel.org>
 <422e6a1e-e76a-4ebc-a0a5-64c47ea57823@gmail.com>
 <Z1h/x+QJD5Uob8GZ@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <Z1h/x+QJD5Uob8GZ@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-GUID: _-mUM4MX5QdGp5ximFBfm-0T6bkGH1As
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDExMiBTYWx0ZWRfXwO+E97D8POY2
 VsJWG4dj45IN+0pYAtDQErNr0SnPyM559D251muUawuTVRLgwYXQmQ3taZxnDj7qlZIqx7Oz9wA
 vIbSyzXYT5JC8jrgdH5qTeNGxdAt2JtBFP/FUBx/JFBFTRND0ACEHL4N1XvLWdoK5cjyop1fUU7
 7r0GqiDTNxCLLLcXARrl0gaA5O4TeNDyEKyb0Sa75H42reqp8WZSht4s0Ow5/sND0FKInLK9Hdx
 pCGK2WAefeVdMKHgSLlJ3l5McmRXIkyi4J/vg+TVeaZvNxF5SRY3owKfiaeLHhBuu7k9wzIPrOl
 LeWzXJxqCHDPOi8dp3LK3gUxddbsKIgI237N3Iv39K25S60dVNoYDI+9zRXQGpQ9/d25KcpSLeZ
 1LhmkP/MCt39mPhMl74NKI/OzI3C6dV+Xr0Vwy/unPgJfb1i3nGpqa6VSChOTatjK5wBGI1B6rL
 WqGgNByfFkd5+eAeWDA==
X-Proofpoint-ORIG-GUID: _-mUM4MX5QdGp5ximFBfm-0T6bkGH1As
X-Authority-Analysis: v=2.4 cv=H8/WAuYi c=1 sm=1 tr=0 ts=69cbb0bb cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=qTFoibyvpqb4MBvfoeQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310112
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[quicinc.com,none];
	R_DKIM_ALLOW(-0.20)[quicinc.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9770-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quic_msavaliy@quicinc.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[quicinc.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 380E5368D49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bjorn, Konrad, Krzysztof, Thanks for all the time and review, 
discussion on this. Really sorry for such long wait, as i was completely 
away from this activity. Now restarting back and will continue on this.

Let me upload v6 as to get context of older series and vet all changes 
and description including DT property flag as the main point of discussion.

On 12/10/2024 11:22 PM, Bjorn Andersson wrote:
> On Tue, Dec 10, 2024 at 01:38:28PM +0100, Konrad Dybcio wrote:
>>
>>
>> On 12/10/24 13:05, Krzysztof Kozlowski wrote:
>>> On 10/12/2024 12:53, Krzysztof Kozlowski wrote:
>>>>>>> I'm not sure a single property name+description can fit all possible
>>>>>>> cases here. The hardware being "shared" can mean a number of different
>>>>>>
>>>>>> Existing property does not explain anything more, either. To recap -
>>>>>> this block is SE and property is named "se-shared", so basically it is
>>>>>> equal to just "shared". "shared" is indeed quite vague, so I was
>>>>>> expecting some wider work here.
>>>>>>
>>>>>>
>>>>>>> things, with some blocks having hardware provisions for that, while
>>>>>>> others may have totally none and rely on external mechanisms (e.g.
>>>>>>> a shared memory buffer) to indicate whether an external entity
>>>>>>> manages power to them.
>>>>>>
>>>>>> We have properties for that too. Qualcomm SoCs need once per year for
>>>>>> such shared properties. BAM has two or three. IPA has two. There are
>>>>>> probably even more blocks which I don't remember now.
>>>>>
>>>>> So, the problem is "driver must not toggle GPIO states", because
>>>>> "the bus controller must not be muxed away from the endpoint".
>>>>> You can come up with a number of similar problems by swapping out
>>>>> the quoted text.
>>>>>
>>>>> We can either describe what the driver must do (A), or what the
>>>>> reason for it is (B).
>>>>>
>>>>>
>>>>> If we go with A, we could have a property like:
>>>>>
>>>>> &i2c1 {
>>>>> 	externally-handled-resources = <(EHR_PINCTRL_STATE | EHR_CLOCK_RATE)>
>>>>> };
>>>>>
>>>>> which would be a generic list of things that the OS would have to
>>>>> tiptoe around, fitting Linux's framework split quite well
>>>>>
>>>>>
>>>>>
>>>>> or if we go with B, we could add a property like:
>>>>>
>>>>> &i2c1 {
>>>>> 	qcom,shared-controller;
>>>>> };
>>>>>
>>>>> which would hide the implementation details into the driver
>>>>>
>>>>> I could see both approaches having their place, but in this specific
>>>>> instance I think A would be more fitting, as the problem is quite
>>>>> simple.
>>>>
>>>>
>>>> The second is fine with me, maybe missing information about "whom" do
>>>> you share it with. Or maybe we get to the point that all this is
>>>> specific to SoC, thus implied by compatible and we do not need
>>>> downstream approach (another discussion in USB pushed by Qcom: I want
>>>> one compatible and 1000 properties).
>>>>
>>>> I really wished Qualcomm start reworking their bindings before they are
>>>> being sent upstream to match standard DT guidelines, not downstream
>>>> approach. Somehow these hundreds reviews we give could result in new
>>>> patches doing things better, not just repeating the same issues.
>>>
>>> This is BTW v5, with all the same concerns from v1 and still no answers
>>> in commit msg about these concerns. Nothing explained in commit msg
>>> which hardware needs it or why the same SoC have it once shared, once
>>> not (exclusive). Basically there is nothing here corresponding to any
>>> real product, so since five versions all this for me is just copy-paste
>>> from downstream approach.
>>
>> So since this is a software contract and not a hardware
>> feature, this is not bound to any specific SoC or "firmware",
>> but rather to what runs on other cores (e.g. DSPs, MCUs spread
>> across the SoC or in a different software world, like TZ).
>>
> 
> I don't think this is a reasonable distinction, the DeviceTree must
> describe the interfaces/environment that the OS is to operate in.
> Claiming that certain properties of that world directly or indirectly
> comes from (static) "software choices" would make the whole concept of
> DeviceTree useless.
> 
> The fact that a serial engine is shared, or not, is a static property of
> the firmware for a given board, no different from "i2c1 being accessible
> by this OS or not" or the fact that i2c1 is actually implement I2C and
> not SPI (i.e. should this node be enabled in the DeviceTree passed to
> the OS or not).
> 
> 
> That said, the commit message still doesn't clearly describe the system
> design or when this property should be set or not, which is what
> Krzysztof has been asking for multiple times.
> 
> Let's circle back and help Mukesh rewrite the commit message such that
> it clearly documents the problem being solved.
> 
In the next patch to be uploaded, Tried to gave clarity on previous 
concerns.

>> Specifying the specific intended use would be helpful though,
>> indeed.
>>
>> Let's see if we can somehow make this saner.
>>
>>
>> Mukesh, do we have any spare registers that we could use to
>> indicate that a given SE is shared? Preferably within the
>> SE's register space itself. The bootloader or another entity
>> (DSP or what have you) would then set that bit before Linux
>> runs and we could skip the bindings story altogether.
>>
>> It would need to be reserved on all SoCs though (future and
>> past), to make sure the contract is always held up, but I
>> think finding a persistent bit that has never been used
>> shouldn't be impossible.
>>
> 
> Let's not invent a custom one-off "hardware description" passing
> interface.
> 
As you know, as such there is no HW flag as of now indicating this HW 
capability or feature. Please let me know if v6 with description about 
static feature flag helps.

If no, then i need to devise some flag (create/add bit) in existing 
HW/FW register and then read back the register to derive feature flag.

I am clear that each DTSI entry describes the hardware, but provided 
such SW based feature, wanted to review.

> Regards,
> Bjorn
> 
>> Konrad


