Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C7625282B
	for <lists+dmaengine@lfdr.de>; Wed, 26 Aug 2020 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHZHFx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Aug 2020 03:05:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54390 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgHZHFv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Aug 2020 03:05:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07Q75noN064369;
        Wed, 26 Aug 2020 02:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598425549;
        bh=6E81PBhhTm2Fd9GLC0elzJej9ab66NBkRVDF3kvJ2Ho=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=G9o+O+AR0hH78Q8eHr9AIslSwHaOq33L0puZqtoxJ/TEtjKaGPYfWBDQntfqcAc/x
         xdNC8A1YH+eFixgP5T0nA3n1uZBanvPsEjEMnui97qwcm1mfLn0Z778hgRi/14JJIh
         39H93UIcj7SK/MfnJHfMKg6GLG4IDrfq6+N2ZByI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07Q75nJe124795;
        Wed, 26 Aug 2020 02:05:49 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 26
 Aug 2020 02:05:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 26 Aug 2020 02:05:49 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07Q75lh7066890;
        Wed, 26 Aug 2020 02:05:47 -0500
Subject: Re: [RFC PATCH 2/3] dmaengine: add peripheral configuration
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200824084712.2526079-1-vkoul@kernel.org>
 <20200824084712.2526079-3-vkoul@kernel.org>
 <50ed780f-4c1a-2da2-71e4-423f3b224e25@ti.com>
 <20200825071023.GB2639@vkoul-mobl>
 <38bc6986-6d1d-7c35-b2df-967326fc5ca7@ti.com>
 <20200825110202.GF2639@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <5d55965f-bb3d-4f3c-803c-e90493f8c197@ti.com>
Date:   Wed, 26 Aug 2020 10:07:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825110202.GF2639@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 25/08/2020 14.02, Vinod Koul wrote:
>> The only thing which might be an issue is that with the DMA_PREP_CMD t=
he
>> config_data is dma_addr_t (via dmaengine_prep_slave_single).
>=20
> Yes I came to same conclusion
>=20
>>> I did have a prototype with metadata but didnt work very well, the
>>> problem is it assumes metadata for tx/rx but here i send the data
>>> everytime from client data.
>>
>> Yes, the intended use case for metadata (per descriptor!) is for
>> channels where each transfer might have different metadata needed for
>> the given transfer (tx/rx).
>>
>> In your case you have semi static peripheral configuration data, which=

>> is not really changing between transfers.
>>
>> A compromise would be to add:
>> void *peripheral_config;
>> to the dma_slave_config, move the set_config inside of the device
>> specific struct you are passing from a client to the core?
>=20
> That sounds more saner to me and uses existing interfaces cleanly. I
> think I like this option ;-)

The other option would be to use the descriptor metadata support and
that might be even cleaner.

In gpi_create_tre() via gpi_prep_slave_sg() you would set up the
desc->tre[1] and desc->tre[2] for TX
desc->tre[2] for RX
in the desc, you add a new variable, let's say first_tre and
set it to 1 for TX, 2 for RX.

If you need to send a config, you attach it via either way metadata
support allows you (get the pointer to desc->tre[0] or give a config
struct to the DMA driver.

In the metadata handler, you check if the transfer is TX, if it is, then
you update desc->tre[0] (or give the pointer to the client) and update
the first_tre to 0.

In issue_pending, or a small helper which can be used to start the
transfer you would do the queuing instead of prepare time:
for (i =3D gpi_desc->first_tre; i < MAX_TRE; i++)
	gpi_queue_xfer(gpii, gpii_chan,  &gpi_desc->tre[i], &wp);

With this change it should work neatly without any change to
dma_slave_config.

>=20
>>>> I'm concerned about the size increase of dma_slave_config (it grows =
by
>>>>> 30 bytes) and for DMAs with hundreds of channels (UDMA) it will add=
 up
>>>> to a sizeable amount.
>>>
>>> I agree that is indeed a valid concern, that is the reason I tagged t=
his
>>> as a RFC patch ;-)
>>>
>>> I see the prep_cmd is a better approach for this, anyone else has bet=
ter
>>> suggestions?
>>>
>>> Thanks for looking in.
>>>
>>
>> - P=C3=A9ter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

