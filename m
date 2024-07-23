Return-Path: <dmaengine+bounces-2730-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247CF93A644
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 20:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97471F21727
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 18:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6FA156C6C;
	Tue, 23 Jul 2024 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MhHQ4nMx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95014C5B0;
	Tue, 23 Jul 2024 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759619; cv=none; b=Y6b7/c7okPKkMuYpTP+kLoy9YQt3x9shQLhoIU9Ob059NknrdMyztWYWbtQmyZ8gfxAZ7+O42i/8iLd7aF619+eaTySicwuGavfeIsxWOk39shUbB6DRGY3bQpAPB2izgAA/yNHOzc0Ui/q/bj5ljhbSl7C+4YKCbWxJ8Z8CS/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759619; c=relaxed/simple;
	bh=Zt6h0sSFWXf716K7FyfqURABtaGF3lQYqJwb+KROOVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e1iDuwf8sROEZrYULJ4ODwWIQeqOkEwQpdS8z7eWjep3FPClNgaRRTrf9BSwSB/YW2q5+1jYlRLUG36pd6NSZrBihJg9EdEhxr+1qdNO39z6YwUScShkRdvZN+V8GguXDHxhNdiozUpYtfNuR1EmtVmF00ziR9uupm0BQSbbWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MhHQ4nMx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NAlUOn010761;
	Tue, 23 Jul 2024 18:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+vGyP9XB+BTIgLebgzrrFiGAtttyG4jmomT4tH2mPDQ=; b=MhHQ4nMxtuRz1SEW
	sUMqRvjuX3J7vqJhZWTxohVYbp5PxgLs7YanSM+eWcZOdeGBDqs/RqqKCBUqSyPl
	sLU4+jRXKV6zj/lZTSs5K+S+0OuINkCajwTUFomGFpllanGwUsRPktxWv1z6YE26
	PmkeoVZhjtofSu5cR3fKf6N+5QHvrPi7THrgJi4ANLiNpVHVVAbk15QFt3ncJCTV
	i+yBPqaELKof9RvYXPfyMbDh5GiAbZesV1EIzC/lEY2l9WJY+lKlgVQswzYMcSvM
	SANQLBqHeMM9c/3J2RZChzx5VlvVvbEeukTL8HYCmSKM2ZzkUtcQUGlvZtzykC4J
	APPQIw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40gurtpjvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:33:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NIXVaf025177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:33:31 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:33:31 -0700
Message-ID: <012dec02-8d19-4873-a3c8-915322639e39@quicinc.com>
Date: Tue, 23 Jul 2024 11:33:30 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Dave
 Jiang <dave.jiang@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20240606-md-drivers-dma-v2-1-0770dfdf74dd@quicinc.com>
 <171778242916.276050.11535562159320987467.b4-ty@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <171778242916.276050.11535562159320987467.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2ERdlMHC0ZLAOq2ilydcwT9j12eQFewi
X-Proofpoint-ORIG-GUID: 2ERdlMHC0ZLAOq2ilydcwT9j12eQFewi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230129

On 6/7/2024 10:47 AM, Vinod Koul wrote:
> 
> On Thu, 06 Jun 2024 13:00:01 -0700, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/idxd/idxd.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/omap-dma.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/dmatest.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ioat/ioatdma.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] dmaengine: add missing MODULE_DESCRIPTION() macros
>       commit: 6e2fb806e08d46cbeb96c1000ef531a92d3b2e9a
> 
> Best regards,

Hi,
I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks!
/jeff

