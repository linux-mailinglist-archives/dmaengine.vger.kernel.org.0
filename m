Return-Path: <dmaengine+bounces-3085-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C3A96EBAD
	for <lists+dmaengine@lfdr.de>; Fri,  6 Sep 2024 09:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9642859CC
	for <lists+dmaengine@lfdr.de>; Fri,  6 Sep 2024 07:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9256414AD24;
	Fri,  6 Sep 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k68I91Ov"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5414A4D1;
	Fri,  6 Sep 2024 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606704; cv=none; b=LX34gx1FeLv7KWs2me9XjijnXjPQLKYRoyOQ5/ZdsZrfZz13YZV2PxvFyOAJmyRCL1LGyPT193EOUYrHdfhTunSB6jmaD5kPMtQRO5PssTRKkan1ZxardRm+hYaJ5/ivFu/zJ8E97KDDb3FrpqjOkLo/cN/vKA4fw/+YaB20d7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606704; c=relaxed/simple;
	bh=GyHlYVgBL/auP1InP8XK5koE23Os6nJlzqwfSe4WXYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hCMdmZZPyKf3VLlnTnzAlc7uTWIjIPfVGaxLV2nqb5FRGwS3yDM0lH2sEyl18sO2paN+X33wlkFeXGiZQYfB6PWuqjti5j7AwGx2qNW7s7YbPPVkuclW/b0Nzb+jLcM5wgEk5Idx8CXDPgpJD75/y5+SGZ+oY8Q1Ecu12J0zPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k68I91Ov; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQW3Z027936;
	Fri, 6 Sep 2024 07:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6BeYPaXE28aa39g6roqci3szIFYugiefH3d+rgWKYBY=; b=k68I91OvJIm5XAkf
	I1muALm9NL3XLdqN/eFarhGXinpU0IuncViyM3osKKNwFtZPritH6ffBruA0E0O6
	ZLWib45XW3NiCQoH7EvjJMegmp10pI4UMAKDQtvnYPI+EO54Cq/tWceAlyJ3CEX6
	iasVioIMfstMN63d5t/9XWpBs39fON9vraw3WTma8vuVxXQZAOqvsePrQaurJfT+
	DhaLXsPbnE/Ds3hi2oK10vRKvQoLh1JHc+cWWFEy6sHQ6D0js8q/QtpZWpXeKjVl
	vYy1+fdkxqnWnDK5xcKYj0GbXlgOSEohHA3mUoIHKxbRNmmwat+g2Ch0GyY5poCU
	/h9/kQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhx1sdn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 07:06:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48676Q1T011879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 07:06:26 GMT
Received: from [10.151.37.94] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Sep 2024
 00:06:20 -0700
Message-ID: <346d4d20-d42d-46eb-b25a-8fb9d0390892@quicinc.com>
Date: Fri, 6 Sep 2024 12:36:17 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 00/16] Add cmd descriptor support
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: Caleb Connolly <caleb.connolly@linaro.org>, <vkoul@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <gustavoars@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <kees@kernel.org>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>, <quic_utiwari@quicinc.com>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <f341e9e9-3da6-4029-9892-90e6ec856544@linaro.org>
 <21fa1207-be83-ffdc-deab-81c070bb94c7@quicinc.com>
 <3vfiwr4uwaejksihd32qb7ryf3euts6urjfqwzhptkivpvo5tv@u4l2mkuoh3ln>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <3vfiwr4uwaejksihd32qb7ryf3euts6urjfqwzhptkivpvo5tv@u4l2mkuoh3ln>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: McB1Xvjb1-XtOMZQh4oFIefqbj59lixt
X-Proofpoint-GUID: McB1Xvjb1-XtOMZQh4oFIefqbj59lixt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060050



On 8/16/2024 9:15 PM, Bjorn Andersson wrote:
> On Fri, Aug 16, 2024 at 05:33:43PM GMT, Md Sadre Alam wrote:
>> On 8/15/2024 6:38 PM, Caleb Connolly wrote:
> [..]
>>> On 15/08/2024 10:57, Md Sadre Alam wrote:
> [..]
>>>>
>>>> tested with "tcrypt.ko" and "kcapi" tool.
>>>>
>>>> Need help to test these all the patches on msm platform
>>>
>>> DT changes here are only for a few IPQ platforms, please explain in the cover letter if this is some IPQ specific feature which doesn't exist on other platforms, or if you're only enabling it on IPQ.
>>
>>     This feature is BAM hardware feature so its applicable for all the QCOM Soc where bam is there. Its not IPQ specific. Will add all the explanation in cover letter in next patch
> 
> Please configure your email client such that your replies follow the
> typical style of mail list discussions. I believe go/upstream has
> instructions for this.
   Ok
> 
>>>
>>> Some broad strokes testing instructions (at the very least) and requirements (testing on what hardware?) aren't made obvious at all here.
>>
>>     Sure will update in cover letter in next patch.
> 
> I'm interested in these instructions as well, but no need to wait for
> another version to provide these instructions. Please just reply here
> (and then include them if there are future versions)

   Requirements:
   In QCE crypto driver we are accessing the crypto engine registers directly via CPU read/write so its possible
   if other subsystem possibly Trust Zone also tries to perform some crypto operations simultaneously, a race
   condition will be created and this could result in undefined behavior.

   To avoid this behavior we need to use BAM HW LOCK/UNLOCK feature on BAM pipes, and this LOCK/UNLOCK will
   be set via sending a command descriptor, where the HLOS/TZ QCE crypto driver prepares a command descriptor
   with a dummy write operation on one of the QCE crypto engine register and pass the LOCK/UNLOCK flag along
   with it.

   This feature tested with tcrypt.ko and "libkcapi" with all the AES algorithm supported by QCE crypto engine.
   Tested on IPQ9574 and qcm6490.LE chipset.

   insmod tcrypt.ko mode=101
   insmod tcrypt.ko mode=102
   insmod tcrypt.ko mode=155
   insmod tcrypt.ko mode=180
   insmod tcrypt.ko mode=181
   insmod tcrypt.ko mode=182
   insmod tcrypt.ko mode=185
   insmod tcrypt.ko mode=186
   insmod tcrypt.ko mode=212
   insmod tcrypt.ko mode=216
   insmod tcrypt.ko mode=403
   insmod tcrypt.ko mode=404
   insmod tcrypt.ko mode=500
   insmod tcrypt.ko mode=501
   insmod tcrypt.ko mode=502
   insmod tcrypt.ko mode=600
   insmod tcrypt.ko mode=601
   insmod tcrypt.ko mode=602

   Encryption command line:
  ./kcapi -x 1 -e -c "cbc(aes)" -k
  8d7dd9b0170ce0b5f2f8e1aa768e01e91da8bfc67fd486d081b28254c99eb423 -i
  7fbc02ebf5b93322329df9bfccb635af -p 48981da18e4bb9ef7e2e3162d16b1910
  * 8b19050f66582cb7f7e4b6c873819b71
  *
  Decryption command line:
  * $ ./kcapi -x 1 -c "cbc(aes)" -k
  3023b2418ea59a841757dcf07881b3a8def1c97b659a4dad -i
  95aa5b68130be6fcf5cabe7d9f898a41 -q c313c6b50145b69a77b33404cb422598
  * 836de0065f9d6f6a3dd2c53cd17e33a

  * $ ./kcapi -x 3 -c sha256 -p 38f86d
  * cc42f645c5aa76ac3154b023359b665375fc3ae42f025fe961fb0f65205ad70e
  * $ ./kcapi -x 3 -c sha256 -p bbb300ac5eda9d
  * 61f7b48577a613fbdfe0d6d90b49985e07a42c99e7a439b6efb76d5ec71b3d30

  ./kcapi -x 12 -c "hmac(sha256)" -k
  0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b -i
  000102030405060708090a0b0c -p f0f1f2f3f4f5f6f7f8f9 -b 42
  *
  3cb25f25faacd57a90434f64d0362f2a2d2d0a90cf1a5a4c5db02d56ecc4c5bf3400720
  8d5b887185865

  Paraller test with two different EE's (Execution Environment)

        EE1 (Trust Zone)                                               EE2 (HLOS)

  There is a TZ application which                             "libkcapi" or "tcrypt.ko" will run in continous loop
  will do continious enc/dec with                                  to do enc/dec with different algorithm supported
  different AES algorithm supported                                QCE crypto engine.
  by QCE crypto engine.

     1) dummy write with LOCK bit set                           1) dummy write with LOCK bit set

     2) bam will lock all other pipes which not                 2) bam will lock all other pipes which not
        belongs to current EE's, i.e HLOS pipe                     belongs to current EE's, i.e tz pipe and
        and keep handling current pipe only.                       keep handling current pipe only.

     3) tz prepare data descriptor and submit to CE5            3) hlos prepare data descriptor and submit to CE5

     4) dummy write with UNLOCK bit set                         4) dummy write with UNLOCK bit set

     5) bam will release all the locked pipes                   5) bam will release all the locked pipes

  Upon encountering a descriptor with Lock bit set, the BAM will lock all other pipes not related to the current pipe group,
  and keep handling the current pipe only until it sees the Un-Lock set (then it will release all locked pipes). The actual
  locking is done on the new descriptor fetching for publishing, i.e. locked pipe will not fetch new descriptors even if it
  got event/events adding more descriptors for this pipe.

> 
> Regards,
> Bjorn

