Return-Path: <dmaengine+bounces-2249-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D0F8D87C0
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24936289755
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CBF136E34;
	Mon,  3 Jun 2024 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iRRgw/eF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8F313792A;
	Mon,  3 Jun 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434806; cv=none; b=Z29D+5Gv4mBg7WRt2tA2zioGyZQe7mumpyvs+vs1VsRbTk6gjm0wZr4hcj3eZ4b37JPlwgIL9sR1SBWHc+LZVuk5smBucpFzrdBYh5+D2TGDGn3Uvn7Ua7mkDjN6PvOYf1ZIh/qUWBVXcD2MO3ItT/ZpoAFDeeSmQJnVgDsNTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434806; c=relaxed/simple;
	bh=GuRckkGxIqRqkRN1xRPmF+yOItGPvl2HAB6FrRkYmF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IKe/Rvp8N0JjDyBzl5Sm5QNLg2KOmfVuhrhRdaXeD9rALoKcwpWPY9xtoGeqt6+jyZX9YHVg7DBpPiBaYjftQls959K4BU8PTfGNLFDHNkHQo8RJHznCWY//IpXZnq4TQglSZqO2OEzaealELi8iHoszQBYNgq3+0DMMghIqmLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iRRgw/eF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453BvbHO021204;
	Mon, 3 Jun 2024 17:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bvwJuGzjJ0MglAc7N5MtbBicWHNWFhGvsAf7k0EcdDU=; b=iRRgw/eF2ANeyFTo
	ORaCrOU72/aJ3g3N1KCfRTTBdWPI8M49rQaytC3CiKZr+j+Iw7NRKpAX9xT8QWCi
	Ia1ISgIJFODzaD8nptkwwciM+e+gr3Z96GlaF8LqnYv1mdv2uVIuToKE9tav+ptz
	YvMtTxG47RdTbsITktD/dQ96e00upSDeTSswmWsO03NAJ7SBVoot30RoET7Awlsy
	InNEPruaSjlCfrwm2WSJN8aFLHApeOVLRm3b7ojkFb0kdP4l6zhdXoIMZLXE8ROg
	wmWhOXrMMno+X0ILtra4Nj0XcyEvTJw45cgbJNbc6p3Ko5Lt+uWfWNZdpJwyaJ+W
	DMePaw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw42vgr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 17:13:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453HDEfr030875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 17:13:14 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 10:13:10 -0700
Message-ID: <9dfe8eac-2da4-6f69-5300-1b953757dba4@quicinc.com>
Date: Mon, 3 Jun 2024 11:13:10 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dmaengine: qcom: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Sinan Kaya <okaya@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <kernel@quicinc.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240603-md-drivers-dma-qcom-v1-1-d1bd919352bf@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240603-md-drivers-dma-qcom-v1-1-d1bd919352bf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PUm823R08Qy_RaFEivk6Lk_q_IHZKnfq
X-Proofpoint-ORIG-GUID: PUm823R08Qy_RaFEivk6Lk_q_IHZKnfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=963 clxscore=1011 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030141

On 6/3/2024 11:06 AM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma_mgmt.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro, using
> the descriptions from the associated Kconfig items.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

