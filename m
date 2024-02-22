Return-Path: <dmaengine+bounces-1064-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEAD85F6B2
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 12:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B231C22DF1
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 11:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE54541202;
	Thu, 22 Feb 2024 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fapB7btn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B64383BD;
	Thu, 22 Feb 2024 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601197; cv=none; b=k/eOF0/c7V8qErea8gWTqyXkRlphhLcmrOwS2p7yY3EZMpOg6te+wBHPjJtHscK/RrVBS3OMaxllPeavW8OLH8anaQ2KuhBq+kvgee5yuXPwjLdA6TGHa8x8n7CFczOXJNsgC7VEkj7vvuXZ6+AGZuPzchw2fY4FlSBlG9/N+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601197; c=relaxed/simple;
	bh=2Kd4s14wqZkMCRnwpdikGJAEHP2RHXdsYnjkDkJ7eKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YS2c0nbvkZ6girzHbw2Vz5eDzwLUdFN5i1XgWhYu2Uodpy9XdQ2dKxFtixyvR+Rjk7dUQ0oL6bMEPpNgWDAz6n3cFp0mJWXdFR7TZlBI8YaJRxRYgQqoNNKQhs50nxKg11r8SDShTSDBFYTxQH1jCRfUCu7GyH6nMWMx+8nrOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fapB7btn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MARvVO004360;
	Thu, 22 Feb 2024 11:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6pbjBpde+8P87En9Lz2352FRm+hT+W2YweU+EV+Mxw8=; b=fa
	pB7btntg2R83JwQFh6M9rIr6dEjK4zNjM/o9czTr4RPh5uP/DQcpI/HkTSEMW7RY
	k67TMR5QcLObv6Eeu1grQt/y32SIP46VFPTuE1JJBe8yo3kp+1PD583im3MRnVLi
	Cqd3J54jUL9d5WyzdG0D4TiJ5Ro3KD7VcD34+Y3CH6nJAQL6dqlsQVrTk804LhMf
	bFSPe6cj81IzpH3gHvFTa7MXXnPv2j1fYgwG44xdpnAHFLkmTc8g65ikY35tyMh4
	/9PZ+0UzRcYnM+pmaJRnvaLEcscq0ddCV99NEqQXZi++MrAihOXG02nmDnbgu1Pi
	IbyTtL7dSni2c/D07RAA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we4dq04j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 11:26:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MBQQB9023542
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 11:26:26 GMT
Received: from [10.201.203.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 03:26:22 -0800
Message-ID: <f4af8317-776f-7530-51af-9cf42eab7b01@quicinc.com>
Date: Thu, 22 Feb 2024 16:56:19 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 03/11] crypto: qce - Convert register r/w for skcipher via
 BAM/DMA
Content-Language: en-US
To: Md Sadre Alam <quic_mdalam@quicinc.com>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <quic_varada@quicinc.com>
References: <20231214114239.2635325-1-quic_mdalam@quicinc.com>
 <20231214114239.2635325-4-quic_mdalam@quicinc.com>
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20231214114239.2635325-4-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ARsGzpSJCaf_ga36d0DVpX0EeUwVve11
X-Proofpoint-ORIG-GUID: ARsGzpSJCaf_ga36d0DVpX0EeUwVve11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220090



On 12/14/2023 5:12 PM, Md Sadre Alam wrote:
> Convert register read/write for skcipher via BAM/DMA.
> with this change all the crypto register configuration
> will be done via BAM/DMA. This change will prepare command
> descriptor for all register and write it once.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>   drivers/crypto/qce/common.c   | 42 +++++++++++++++++++++--------------
>   drivers/crypto/qce/skcipher.c | 12 ++++++++++
>   2 files changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
> index 04253a8d3340..d1da6b1938f3 100644
> --- a/drivers/crypto/qce/common.c
> +++ b/drivers/crypto/qce/common.c

  Changes to common.c should have been in patch #2 ?
  Btw, if we are making cmd desc approach as default for all socs
  we should have it tested in all platforms ?

Regards,
  Sricharan

