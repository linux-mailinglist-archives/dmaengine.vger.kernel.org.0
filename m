Return-Path: <dmaengine+bounces-892-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8B984260F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 14:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE231F24FFD
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307A6BB34;
	Tue, 30 Jan 2024 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mYl2brf5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8160874;
	Tue, 30 Jan 2024 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620767; cv=none; b=WyIhxKsArkI68fYFtikOexX8trqpwimyDdg6gmWwIsxWbqc+DtoVWlutDT0NMMvYXT78z0FEdM5rtP5Vkk5AFSYO6axsrwv/WGiVS66EVb/siWQo2JqGyzf2nGVIeF0UUYWUI3uber6VEjMpLEhTD9mCSQgXlA2tqUoGo3lcznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620767; c=relaxed/simple;
	bh=4A4P0uoIH22Pj/8ZZK68o4PUetBKhjiM5+2BHQM5qS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dYVcCyTgCBAdO8WmCt4Qe1xb4utPzidajJ4FUimOhSvwiqdLveh/0+IR0pL5MOTXqxnC7ZEuoIOdiDKfZWBGT0QRuRsvTflhkFDcjSMwBamf0T35iOQT4rhDJ8E4Q7ImMZYEmj6D2xv2p/nIjW0uiZMOjK00UH27N29M/Ze/zD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mYl2brf5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UAUcOC006626;
	Tue, 30 Jan 2024 13:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zSn8G5clqP1F5joA8rvlouwTo37FDpDga5azQ0UnSMk=; b=mY
	l2brf5Cx4WhCsBKsnmQBNJnwSkycyNZUaElWNe4QA6cmfNcyJ8RqVEWMk4S60N/d
	M/PKd6QcifD74ko5+jwcz2Tg4ZrdMk6ZbfKuEI6lCsPfHt82zNajMCvhv2kFnjga
	syZyAJiiMwqsNsJm4i/bnNJv2CfFRq/N/eebCKswwiOHYaNGMqF2x4+S8Acyk8hV
	JTkjxoDS+By5q2FTGiYMO9ps9J22G8lmc9iJ69mzJsemcvPfujYZqd8WrFFGnxPS
	7zIcJU+0H2jvC0hgkvuOoJAxfSzkaGlT2m0RKF2WBv4L0TTtsI/WJs/LE8I/+B89
	tga1sQ3r/8C31+WuMbvQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxydh0cee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 13:19:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UDJ5mg016445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 13:19:05 GMT
Received: from [10.218.10.86] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 05:18:57 -0800
Message-ID: <9daddb2a-e20c-6189-f319-e343eb918248@quicinc.com>
Date: Tue, 30 Jan 2024 18:48:35 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 5/6] PCI: qcom-ep: Provide number of read/write channel
 for HDMA
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <vkoul@kernel.org>, <jingoohan1@gmail.com>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>, <quic_parass@quicinc.com>,
        <quic_schintav@quicinc.com>, <quic_shijjose@quicinc.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Kishon Vijay Abraham
 I" <kishon@kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
 <1705669223-5655-6-git-send-email-quic_msarkar@quicinc.com>
 <20240130085301.GB83288@thinkpad>
Content-Language: en-US
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <20240130085301.GB83288@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8GmV8PNkEEBYkv4MFnp5j7xycW1G7OpK
X-Proofpoint-GUID: 8GmV8PNkEEBYkv4MFnp5j7xycW1G7OpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=876
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300098


On 1/30/2024 2:23 PM, Manivannan Sadhasivam wrote:
> On Fri, Jan 19, 2024 at 06:30:21PM +0530, Mrinmay Sarkar wrote:
>> There is no standard way to auto detect the number of available
>> read/write channels in a platform. So adding this change to provide
>> read/write channels count and also provide "EDMA_MF_HDMA_NATIVE"
>> flag to support HDMA for 8775 platform.
>>
>> 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for
>> this platform. Add struct qcom_pcie_ep_cfg as match data. Assign
>> hdma_supported flag into struct qcom_pcie_ep_cfg and set it true
>> in cfg_1_34_0.
>>
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 45008e0..8d56435 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -149,6 +149,10 @@ enum qcom_pcie_ep_link_status {
>>   	QCOM_PCIE_EP_LINK_DOWN,
>>   };
>>   
> Add kdoc comment please as like the below struct.
>
>> +struct qcom_pcie_ep_cfg {
>> +	bool hdma_supported;
>> +};
>> +
>>   /**
>>    * struct qcom_pcie_ep - Qualcomm PCIe Endpoint Controller
>>    * @pci: Designware PCIe controller struct
>> @@ -167,6 +171,7 @@ enum qcom_pcie_ep_link_status {
>>    * @num_clks: PCIe clocks count
>>    * @perst_en: Flag for PERST enable
>>    * @perst_sep_en: Flag for PERST separation enable
>> + * @cfg: PCIe EP config struct
>>    * @link_status: PCIe Link status
>>    * @global_irq: Qualcomm PCIe specific Global IRQ
>>    * @perst_irq: PERST# IRQ
>> @@ -194,6 +199,7 @@ struct qcom_pcie_ep {
>>   	u32 perst_en;
>>   	u32 perst_sep_en;
>>   
>> +	const struct qcom_pcie_ep_cfg *cfg;
>>   	enum qcom_pcie_ep_link_status link_status;
>>   	int global_irq;
>>   	int perst_irq;
>> @@ -511,6 +517,10 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
>>   	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
>>   }
>>   
>> +static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
>> +	.hdma_supported = true,
>> +};
>> +
>>   /* Common DWC controller ops */
>>   static const struct dw_pcie_ops pci_ops = {
>>   	.link_up = qcom_pcie_dw_link_up,
>> @@ -816,6 +826,13 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
>>   	pcie_ep->pci.ops = &pci_ops;
>>   	pcie_ep->pci.ep.ops = &pci_ep_ops;
>>   	pcie_ep->pci.edma.nr_irqs = 1;
>> +
>> +	pcie_ep->cfg = of_device_get_match_data(dev);
> Why do you want to cache "cfg" since it is only used in probe()?

Yes Mani, no need to cache "cfg" we can use directly here .

>> +	if (pcie_ep->cfg && pcie_ep->cfg->hdma_supported) {
>> +		pcie_ep->pci.edma.ll_wr_cnt = 1;
>> +		pcie_ep->pci.edma.ll_rd_cnt = 1;
> Is the platform really has a single r/w channel?
the platform has 8 r/w channels. but as per the use case we need to use 
single r/w channel.
> - Mani
Thanks,
Mrinmay

