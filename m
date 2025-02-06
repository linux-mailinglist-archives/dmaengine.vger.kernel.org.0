Return-Path: <dmaengine+bounces-4317-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9B2A2A8AA
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 13:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D11888546
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ECA22DF86;
	Thu,  6 Feb 2025 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RlYu1OA8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E1225A2F;
	Thu,  6 Feb 2025 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738845859; cv=none; b=W2Y//yIangQBYQRfby74cCqxkRH/ef4JGLlASZwMh/K2/8lkh3UBj8Y+1rQILjs11tB1Ty21TUqwOcJ7SEVgU1j/DRXHB4SfOA9g+4AqGfSCZN9flY2AZexRc36LxTvR782aHINVvoYq7LSWjqBFT+HVhFxe1I/t8MdA665ggm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738845859; c=relaxed/simple;
	bh=W6jZDK8jApWktPMHm3xVv1mSc6QAOfCwzZr+TF7SbOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LoPhmjiIdWT+zxQItuauyBkqsohzItqA9aTPKaRmEHO4AGIOcsJkSRS4MAQHlffSRabyWBc1XwTB91zaezBdGwa22h+ldsshR5r3eytY6ffqU5r9MS8CAaYlqIkX5DgzQoGSnUb0td6crZg9nzfA02ftyQZdYT60VKMYIN2F0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RlYu1OA8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516AGVtk015699;
	Thu, 6 Feb 2025 12:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L+VuwwPUX96t/cvLAig0W9CrSmNSvF+GAw2WUICZpBM=; b=RlYu1OA8BRoZs37J
	AlZng96pHzMmd5b/WS3mArhheJxQZkg6wK1Uu8SnYgsX7gZ4zD3Nwywdi2TrgQ/C
	GyfiRQP7RNKoMpqdyOOGScg/0hvqvCllrhy6E0Y7u2sk1pY0wjXE+zTmvDcI1DZn
	xnDdgS1E83WqXxVI/EZFbrOPZsAOr997ybn+R+beI6/3xzH4GKU4/HzFL9ogcebC
	k3y7x/vCJsXs3cD0ZwTmJx1BeyIdu3GBrW8H5JuVZMpGT6jrS1itMQOOSlmtiCNR
	7dQFerqlN+/t/eYGocVaXBAve+8g0Cfsne1qzTX/EHp5UMvpO+I8rLQL4g/Bqa+G
	gk1Zbw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44mu6f0b3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 12:43:06 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 516Ch5Z4004850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 12:43:05 GMT
Received: from [10.216.49.103] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Feb 2025
 04:42:52 -0800
Message-ID: <689302c6-8fba-4fd1-a4b7-557cb2f8fa4d@quicinc.com>
Date: Thu, 6 Feb 2025 18:12:47 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] dt-bindings: pci: Add fsl,mpc83xx-pcie bindings
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Frank Li
	<Frank.li@nxp.com>
CC: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        Scott Wood
	<oss@buserror.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael
 Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao
	<naveen@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Damien Le Moal
	<dlemoal@kernel.org>,
        Niklas Cassel <cassel@kernel.org>,
        Herbert Xu
	<herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Lee
 Jones <lee@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?J=2E_Neusch=C3=A4fer?=
	<j.neuschaefer@gmx.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter
 Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
        Miquel Raynal
	<miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-6-50649f51c3dd@posteo.net>
 <Z5qx3jAFE81Ni2cJ@lizhi-Precision-Tower-5810> <Z6KkBEaGTkSyWiE_@probook>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <Z6KkBEaGTkSyWiE_@probook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TE8H3f9cFLjJrvrDo3x9nlVxTSkbm7Tn
X-Proofpoint-ORIG-GUID: TE8H3f9cFLjJrvrDo3x9nlVxTSkbm7Tn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=657 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060105



On 2/5/2025 5:04 AM, J. Neuschäfer wrote:
> On Wed, Jan 29, 2025 at 05:55:26PM -0500, Frank Li wrote:
>> On Sun, Jan 26, 2025 at 07:59:01PM +0100, J. Neuschäfer wrote:
>>> Supplement Documentation/devicetree/bindings/pci/fsl,pci.txt with a more
>>> formal binding in YAML format.
>>>
neat: subject: since binding is already mentioned in the prefix of the 
subject, no need to add bindings word again.
>>> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
>>> ---
>>>   .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 83 ++++++++++++++++++++++
>>>   1 file changed, 83 insertions(+)
> [...]
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    pci1: pcie@e0009000 {
>>
>> needn't label here
> 
> Will change.
> 
> 
> Thanks,
> J. Neuschäfer
> 


