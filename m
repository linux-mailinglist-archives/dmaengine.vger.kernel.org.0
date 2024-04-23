Return-Path: <dmaengine+bounces-1943-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E958AF408
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 18:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2611F2367D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B9813F437;
	Tue, 23 Apr 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WxnCeEO6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905AE13EFE5;
	Tue, 23 Apr 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889550; cv=none; b=VOF8L1J/1GAeHliIZgrAy0L8w59kHoOdLJm5sN3w/EqJtk7q6HqDSFpL33H9CpnieUgTRL3X1yX9X41nZoviO0HARO2F7zPc4wPWSHgszBaSYh0qkPJRF5FGjjI4BRvXIJGkJwkHit69s2iOr7Cgf3NnLhAH7UUp4BnrIk8Pt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889550; c=relaxed/simple;
	bh=selTvwPRVCABjm1HQhe7V2kfCqkDDvT5fefTH7nNXN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q/AwiP7EzUIyTnJTnqiJb8jflqSDPdmwxPp0loih7ccG/o3hFvW3sXezVmaY9buXhkXEfI+BlESlbOoG45b/7X6KS/S2ic0BdseLYgmJID5t9GCWYlmyUtO/G799LsVa3KhGYeOdESqeksf0xxM2BUnJ3deNSitZBARJGfGY+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WxnCeEO6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N8IcXC022096;
	Tue, 23 Apr 2024 16:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NDEho3uAV1nyYlvcJIIrLldXexiCVZwvoJHuX3+MTgw=; b=Wx
	nCeEO6Peuxgp6KUlDwI8FyJ1K9Xv3SWlI1QJLDrRl3X4P7Uw76erOLg1TtDBaTOE
	g+F0/mMXxJEOQe5Xn8UX5gce5D1NA+8ifuE4xJ8VrAHhbCtOOfdCNkXmuHuwOibL
	bFQN40kLQHE2cRS9VZNSRKxhMrvkCblvs4OoEI5EKCpewcrVG35b+fXIfJMq4hnm
	vwtUU9I5N0uCyFgAqTNsVruh+SGIK2hPIIQwJ/Ca7QG9YLLZRXww2DhARiopL2UU
	1za65XIOY7BOm1xCWkmUG7wl1v7bz4S48odoLG9yZKk9HujHZCe+PDz0WiTzxv3q
	TDJzfRU1dq4Y9P7lzGyw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp9bu9ed3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 16:25:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NGPfmO002838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 16:25:41 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 09:25:40 -0700
Message-ID: <96868bd1-aac1-ac1d-0f36-143c6aca761f@quicinc.com>
Date: Tue, 23 Apr 2024 10:25:33 -0600
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/2] dt-bindings: dma: Drop unused QCom hidma binding
Content-Language: en-US
To: "Rob Herring (Arm)" <robh@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240423161413.481670-1-robh@kernel.org>
 <20240423161413.481670-2-robh@kernel.org>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240423161413.481670-2-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: irD2PcjKW0URdMpnVYKwIy5eGj8ljbJc
X-Proofpoint-ORIG-GUID: irD2PcjKW0URdMpnVYKwIy5eGj8ljbJc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_14,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=808 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230037

On 4/23/2024 10:14 AM, Rob Herring (Arm) wrote:
> The QCom hidma binding was used on a defunct QCom server platform which
> mainly used ACPI. DT support in the Linux driver has been broken since
> 2018, so it seems this binding is unused and can be dropped.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

