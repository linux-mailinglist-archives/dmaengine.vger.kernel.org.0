Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 811338342F
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2019 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbfHFOpV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Aug 2019 10:45:21 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9507 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbfHFOpV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Aug 2019 10:45:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4992890000>; Tue, 06 Aug 2019 07:45:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 06 Aug 2019 07:45:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 06 Aug 2019 07:45:19 -0700
Received: from [10.25.74.165] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Aug
 2019 14:45:16 +0000
Subject: Re: [PATCH v2] dmaengine: tegra210-adma: fix transfer failure
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>
CC:     <thierry.reding@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1562929830-29344-1-git-send-email-spujar@nvidia.com>
 <da482fff-a2dd-9bcd-5b77-d8a4bad4db1a@nvidia.com>
Message-ID: <c18afd12-b50d-ea1c-f6ef-1f5c1443c6a9@nvidia.com>
Date:   Tue, 6 Aug 2019 20:15:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <da482fff-a2dd-9bcd-5b77-d8a4bad4db1a@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565102729; bh=hy05jr2v5HUUo2xzflp2THUPuH1cr1bU8hCtlB4HY8Q=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=g9TXRRz3fbSYtn7WYIw3eBBfyswxXBv6l0o0vipu87kL887KpOvcQwUw7lZX8mdUs
         7KoXGj7sot1bjtGjVVUZwlQ4VLjdrcnM6hRg153rZS7NjnhSrV0C6F30nK//bQsijq
         5mx0p2H6Ka48Ytv9+tQR2ZKz8vbe4ueC0Yfr9OZDDmkkYYclfco6u+x5Xlg4fAyZ8m
         /pKnuXiVLW0RCclPQ5laWI9Wmg5kBw/gU/Qw4Gldcr89ktYHqmOXEfhnzj6hiBA0WN
         0rzAcPt2pj41fR1i406Wm7Cg4VGLL+Wluta9n3R26Fn9rdfQeDU618ULLGgVYaAo54
         Vf65DBJrhYYIQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Request for review.

On 7/23/2019 11:41 AM, Sameer Pujar wrote:
> Hi Reviewers,
>
> Please review.
>
> Thanks,
> Sameer.
>
> On 7/12/2019 4:40 PM, Sameer Pujar wrote:
>> =C2=A0From Tegra186 onwards OUTSTANDING_REQUESTS field is added in chann=
el
>> configuration register(bits 7:4) which defines the maximum number of=20
>> reads
>> from the source and writes to the destination that may be outstanding at
>> any given point of time. This field must be programmed with a value
>> between 1 and 8. A value of 0 will prevent any transfers from happening.
>>
>> Thus added 'ch_pending_req' member in chip data structure and the=20
>> same is
>> populated with maximum allowed pending requests. Since the field is not
>> applicable to Tegra210, mentioned bit fields are unused and hence the
>> member is initialized with 0. For Tegra186, by default program this=20
>> field
>> with the maximum permitted value of 8.
>>
>> Fixes: 433de642a76c ("dmaengine: tegra210-adma: add support for=20
>> Tegra186/Tegra194")
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>> =C2=A0 drivers/dma/tegra210-adma.c | 7 +++++++
>> =C2=A0 1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>> index 2805853..5ab4e3a9 100644
>> --- a/drivers/dma/tegra210-adma.c
>> +++ b/drivers/dma/tegra210-adma.c
>> @@ -74,6 +74,8 @@
>> TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3)=C2=A0=C2=A0=C2=A0 | \
>> TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(3))
>> =C2=A0 +#define TEGRA186_DMA_MAX_PENDING_REQS=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8
>> +
>> =C2=A0 #define ADMA_CH_REG_FIELD_VAL(val, mask, shift) (((val) & mask) <=
<=20
>> shift)
>> =C2=A0 =C2=A0 struct tegra_adma;
>> @@ -85,6 +87,7 @@ struct tegra_adma;
>> =C2=A0=C2=A0 * @ch_req_tx_shift: Register offset for AHUB transmit chann=
el select.
>> =C2=A0=C2=A0 * @ch_req_rx_shift: Register offset for AHUB receive channe=
l select.
>> =C2=A0=C2=A0 * @ch_base_offset: Register offset of DMA channel registers=
.
>> + * @ch_pending_req: Outstaning DMA requests for a channel.
>> =C2=A0=C2=A0 * @ch_fifo_ctrl: Default value for channel FIFO CTRL regist=
er.
>> =C2=A0=C2=A0 * @ch_req_mask: Mask for Tx or Rx channel select.
>> =C2=A0=C2=A0 * @ch_req_max: Maximum number of Tx or Rx channels availabl=
e.
>> @@ -98,6 +101,7 @@ struct tegra_adma_chip_data {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ch_req_tx_shift;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ch_req_rx_shift;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ch_base_offset;
>> +=C2=A0=C2=A0=C2=A0 unsigned int ch_pending_req;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ch_fifo_ctrl;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ch_req_mask;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ch_req_max;
>> @@ -602,6 +606,7 @@ static int tegra_adma_set_xfer_params(struct=20
>> tegra_adma_chan *tdc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ADMA_CH_CTRL_FLOWCTRL_EN;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch_regs->config |=3D cdata->adma_get_burs=
t_config(burst_size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch_regs->config |=3D ADMA_CH_CONFIG_WEIGH=
T_FOR_WRR(1);
>> +=C2=A0=C2=A0=C2=A0 ch_regs->config |=3D cdata->ch_pending_req;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch_regs->fifo_ctrl =3D cdata->ch_fifo_ctr=
l;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch_regs->tc =3D desc->period_len & ADMA_C=
H_TC_COUNT_MASK;
>> =C2=A0 @@ -786,6 +791,7 @@ static const struct tegra_adma_chip_data=20
>> tegra210_chip_data =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_req_tx_shift=C2=A0=C2=A0=C2=A0 =3D 28=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_req_rx_shift=C2=A0=C2=A0=C2=A0 =3D 24=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_base_offset=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D 0,
>> +=C2=A0=C2=A0=C2=A0 .ch_pending_req=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 0,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_fifo_ctrl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D TEGRA210_FIFO_CTRL_DEFAULT,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_req_mask=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D 0xf,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_req_max=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D 10,
>> @@ -800,6 +806,7 @@ static const struct tegra_adma_chip_data=20
>> tegra186_chip_data =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_req_tx_shift=C2=A0=C2=A0=C2=A0 =3D 27=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_req_rx_shift=C2=A0=C2=A0=C2=A0 =3D 22=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_base_offset=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D 0x10000,
>> +=C2=A0=C2=A0=C2=A0 .ch_pending_req=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D (TEGRA186_DMA_MAX_PENDING_REQS << 4),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_fifo_ctrl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D TEGRA186_FIFO_CTRL_DEFAULT,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_req_mask=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D 0x1f,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_req_max=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D 20,
