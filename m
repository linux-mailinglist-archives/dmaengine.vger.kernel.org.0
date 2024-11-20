Return-Path: <dmaengine+bounces-3751-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F17839D3406
	for <lists+dmaengine@lfdr.de>; Wed, 20 Nov 2024 08:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0411F22B82
	for <lists+dmaengine@lfdr.de>; Wed, 20 Nov 2024 07:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A0158DD8;
	Wed, 20 Nov 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g7s66ngb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352E156F20;
	Wed, 20 Nov 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086962; cv=none; b=tBh3grUcaKq6KlWtjXG+rwxpd7dnnAlx6ECkJKnj9pBuG9pTVQKSkN60JbLsxSVrxc2jYa5UK30eEdWuwmuBpFm0+2labN9WZejr7EIaTjqqnDV8Qp9/pGDOLCLVyDX/qMRqvDg+lnBb4XH4ViheqSq7ZlU/naScey+ePakd+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086962; c=relaxed/simple;
	bh=O+5EW+kYgMZHMUvAUtqH+rsPKYUp62KkGmPwmRdo3mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kF1A2mMvMnwNeTAFyAayKk82NLR8FgHPT66+sWjRTAzc2LOKTca+0sf8TchRESyisMlygu298DhLfBJV44Nmqf2dL8Nr1lDYSyv13I1WThS3EFeadHAEVlaIfOq8JowAdgZSlGwQw67aXXgYc1YdND600f8BZunQmwKlzfWhCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g7s66ngb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJIJlpJ006450;
	Wed, 20 Nov 2024 07:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w6f/FBJ+DYPJOf1vHAnZkatNodRxfvfgrInCPH1jYcs=; b=g7s66ngb+16fQ7Rj
	EX4VcYVXL2vSnZcFLEdZCNURtXL3KRIqc87m7hTSzgsHQHBD2PKxWFiFcGrtLpQA
	4XA5l16f/nXmVotOf7utFgi7rA9dSX4YKi07E8i0ODwdR2t8lGe355PB0LykylhO
	b9r3BaGF6FxzcPqDlwXGBV063nuiZ+idyRZarkRGzCBsaMOr5VFUQh8xD7/uNf5v
	qJi2BIyONM5YNen0d23vLaAPi3FN1XjPMuPgB+KO3S+0ikLuO3TUX2JRpyysRgt/
	oI+eH6U0fZH7UoVTb/iPeRGK19EpF5d+tWFdUG5KH1Nb9dt3nvqFssDxv1ZSG0ie
	5knsVA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y8n1yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 07:15:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AK7Fljl019460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 07:15:47 GMT
Received: from [10.152.197.144] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 23:15:41 -0800
Message-ID: <ad5dcd6c-1dbf-d682-024a-d4093611388f@quicinc.com>
Date: Wed, 20 Nov 2024 12:45:14 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 00/11] dmaengine: qcom: bam_dma: add cmd descriptor
 support
To: <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <vkoul@kernel.org>, <kees@kernel.org>,
        <robin.murphy@arm.com>, <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <u.kleine-koenig@pengutronix.d>, <linux-crypto@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20240909092632.2776160-1-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240909092632.2776160-1-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KP8Vcm6gV2KAGptVFxVFtFXNUdHum8Kz
X-Proofpoint-GUID: KP8Vcm6gV2KAGptVFxVFtFXNUdHum8Kz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=648 lowpriorityscore=0 clxscore=1011 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200052



On 9/9/2024 2:56 PM, Md Sadre Alam wrote:
> Requirements:
>    In QCE crypto driver we are accessing the crypto engine registers
>    directly via CPU read/write. Trust Zone could possibly to perform some
>    crypto operations simultaneously, a race condition will be created and
>    this could result in undefined behavior.
> 
>    To avoid this behavior we need to use BAM HW LOCK/UNLOCK feature on BAM
>    pipes, and this LOCK/UNLOCK will be set via sending a command descriptor,
>    where the HLOS/TZ QCE crypto driver prepares a command descriptor with a
>    dummy write operation on one of the QCE crypto engine register and pass
>    the LOCK/UNLOCK flag along with it.
> 
>    This feature tested with tcrypt.ko and "libkcapi" with all the AES
>    algorithm supported by QCE crypto engine. Tested on IPQ9574 and
>    qcm6490.LE chipset.

Hi,

Could you please provide feedback for this patch series.

Thanks
Alam.



