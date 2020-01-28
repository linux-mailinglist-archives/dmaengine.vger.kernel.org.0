Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD42A14BB32
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 15:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgA1OoQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 09:44:16 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9947 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgA1OK3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 09:10:29 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3040c10000>; Tue, 28 Jan 2020 06:10:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 28 Jan 2020 06:10:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 28 Jan 2020 06:10:28 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan
 2020 14:10:26 +0000
Subject: Re: [PATCH v4 11/14] dmaengine: tegra-apb: Clean up suspend-resume
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-12-digetx@gmail.com>
 <7e0d2cfa-5570-93e6-e3dc-7d3f6902a528@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <831d5e28-72df-3175-bfb6-b33985d93a52@nvidia.com>
Date:   Tue, 28 Jan 2020 14:10:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7e0d2cfa-5570-93e6-e3dc-7d3f6902a528@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580220609; bh=xangnqYvsjXB6uZCwVU6QEfMGdk7H6fMiwcZ4U+Wll0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CATh8fg/+NuOJ6Y6kBLaJZ4AMi/2jad+XiXGUA+DbDj7pJ/knJbOhoraiWgIM4FCb
         55IlASAe8BQElryRSxQZfveKJrZ+XYFnKuVmChs4EkXUHu3rHZJsRRuh36t1ZBpT9v
         H+muQ/RUvUVBRX6Q5g9Ok4+y+oqfsngRQs2PkIyf5eKUOsuyckYxxK0eJTmdnsUdMY
         mAvNZxZnXyzXbAe3GFSiQk3Uycsj0S5y+iVoXlMimrM09rqjzTmaUFZGMnYxP0ljl2
         kd5xIrp+RmVS8O7yePS9TEabvMlt88qHWsO/Gb96/dgm7cFq+H4NxmplF+UNFe91Tj
         HsPuTEMbxqkFA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 21/01/2020 21:23, Dmitry Osipenko wrote:
> 12.01.2020 20:30, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> It is enough to check whether hardware is busy on suspend and to reset
>> it across of suspend-resume because channel's configuration is fully
>> re-programmed on each DMA transaction anyways and because save-restore
>> of an active channel won't end up well without pausing transfer prior to
>> saving of the state (note that all channels shall be idling at the time =
of
>> suspend, so save-restore is not needed at all).
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/dma/tegra20-apb-dma.c | 131 +++++++++++++++++-----------------
>>  1 file changed, 67 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma=
.c
>> index b9d8e57eaf54..398a0e1d6506 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -1392,6 +1392,36 @@ static const struct tegra_dma_chip_data tegra148_=
dma_chip_data =3D {
>>  	.support_separate_wcount_reg =3D true,
>>  };
>> =20
>> +static int tegra_dma_init_hw(struct tegra_dma *tdma)
>> +{
>> +	int err;
>> +
>> +	err =3D reset_control_assert(tdma->rst);
>> +	if (err) {
>> +		dev_err(tdma->dev, "failed to assert reset: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	err =3D clk_enable(tdma->dma_clk);
>> +	if (err) {
>> +		dev_err(tdma->dev, "failed to enable clk: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	/* reset DMA controller */
>> +	udelay(2);
>> +	reset_control_deassert(tdma->rst);
>> +
>> +	/* enable global DMA registers */
>> +	tdma_write(tdma, TEGRA_APBDMA_GENERAL, TEGRA_APBDMA_GENERAL_ENABLE);
>> +	tdma_write(tdma, TEGRA_APBDMA_CONTROL, 0);
>> +	tdma_write(tdma, TEGRA_APBDMA_IRQ_MASK_SET, 0xFFFFFFFF);
>> +
>> +	clk_disable(tdma->dma_clk);
>> +
>> +	return 0;
>> +}
>> +
>>  static int tegra_dma_probe(struct platform_device *pdev)
>>  {
>>  	const struct tegra_dma_chip_data *cdata;
>> @@ -1433,30 +1463,18 @@ static int tegra_dma_probe(struct platform_devic=
e *pdev)
>>  	if (ret)
>>  		return ret;
>> =20
>> +	ret =3D tegra_dma_init_hw(tdma);
>> +	if (ret)
>> +		goto err_clk_unprepare;
>> +
>>  	pm_runtime_irq_safe(&pdev->dev);
>>  	pm_runtime_enable(&pdev->dev);
>>  	if (!pm_runtime_enabled(&pdev->dev)) {
>>  		ret =3D tegra_dma_runtime_resume(&pdev->dev);
>>  		if (ret)
>>  			goto err_clk_unprepare;
>=20
> Jon, but isn't the RPM mandatory for all Tegra SoCs now and thus
> guaranteed to be enabled? Maybe we should start to remove handling the
> case of unavailable RPM from all Tegra drivers?

Yes that's true, even ARCH_TEGRA selects PM now

Cheers
Jon

--=20
nvpublic
