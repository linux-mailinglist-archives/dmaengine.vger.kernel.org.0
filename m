Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2619E2C36
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2019 10:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfJXIc5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Oct 2019 04:32:57 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25440 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJXIc5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Oct 2019 04:32:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571905966; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fuh9qei8RdUSfY5W0FLhIUYatGRLIOqxNwteNfbFB94MmNS6tS9OnmZlseSGPOGpeNlP4BZJq0/4oh8HBctW6+F8pNUkotmum/x/42DaE2MsbEA0fOpABCB3vlS4JwI2Z54vq3h1GIYWxB+sFScYoCbdO+0INkBjlYj5ZfmQztU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571905966; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6qjWp9fOyWXfySwwwbqXJ9MJYL8BpwYnEj4RnXxr3K0=; 
        b=g6tP5B5WfnSbo7nK9MlX7ieHngqDxhkZwHQ+J4G4zqgtYSGJIEbJByBclIpqp6W80WTiHaAp8OpZkgm/txeUIPkBuxGEnS4o8JvWq+sviDiNr5KIGvjWBq2epNRj4GeCiq+k4uSITEBhwYjSxPTXPO+ciqx2t4XazmfARl+sJlA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=en++J+n2joHAE3eJ8yZSg9AttC6X5AzJq1oawRX50ORH983ZZsk1Um/Bx7JuxaKLH2AtTFAtsW3U
    SL1L8HyyrcNFd0v2MP7nYknMaTKf9oPdwO/JAdvi01XwAenHajDz  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571905966;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=1787; bh=6qjWp9fOyWXfySwwwbqXJ9MJYL8BpwYnEj4RnXxr3K0=;
        b=dNMkj4Zsv4tqbI+z0VZv7QNXVAuBkCy15ENTYe6qiRhXHHnf0ssLJhp4/rUA1fZJ
        e7jGdLKjE8ircJ+TUd5E5mKulQA6gKCSA/Gqwa6Hd3BZ8w17bMV7ecswFK0qK3sk30/
        fVrHOsfP02VtnepJcqgDFggLyAZqhJ73kuS2SwcQ=
Received: from [192.168.88.140] (182.148.156.27 [182.148.156.27]) by mx.zohomail.com
        with SMTPS id 1571905962349714.4127332922549; Thu, 24 Oct 2019 01:32:42 -0700 (PDT)
Subject: Re: [PATCH RESEND 2/2] dmaengine: JZ4780: Add support for the X1000.
To:     Paul Cercueil <paul@crapouillou.net>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
 <1571814137-46002-1-git-send-email-zhouyanjie@zoho.com>
 <1571814137-46002-3-git-send-email-zhouyanjie@zoho.com>
 <1571846901.3.0@crapouillou.net>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, vkoul@kernel.org,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5DB1619F.8080904@zoho.com>
Date:   Thu, 24 Oct 2019 16:32:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1571846901.3.0@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Hi Paul,

On 2019=E5=B9=B410=E6=9C=8824=E6=97=A5 00:08, Paul Cercueil wrote:
> Hi Zhou,
>
>
> Le mer., oct. 23, 2019 at 15:02, Zhou Yanjie <zhouyanjie@zoho.com> a=20
> =C3=A9crit :
>> Add support for probing the dma-jz4780 driver on the X1000 Soc.
>>
>> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
>> ---
>>  drivers/dma/dma-jz4780.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
>> index cafb1cc0..f809a6e 100644
>> --- a/drivers/dma/dma-jz4780.c
>> +++ b/drivers/dma/dma-jz4780.c
>> @@ -1019,11 +1019,18 @@ static const struct jz4780_dma_soc_data=20
>> jz4780_dma_soc_data =3D {
>>      .flags =3D JZ_SOC_DATA_ALLOW_LEGACY_DT |=20
>> JZ_SOC_DATA_PROGRAMMABLE_DMA,
>>  };
>>
>> +static const struct jz4780_dma_soc_data x1000_dma_soc_data =3D {
>> +    .nb_channels =3D 8,
>> +    .transfer_ord_max =3D 7,
>> +    .flags =3D JZ_SOC_DATA_ALLOW_LEGACY_DT |=20
>> JZ_SOC_DATA_PROGRAMMABLE_DMA,
>
> Please don't use JZ_SOC_DATA_ALLOW_LEGACY_DT for new bindings.
>
> With that flag removed:
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>

I'll remove it in v2.

Best regards!

>
>> +};
>> +
>>  static const struct of_device_id jz4780_dma_dt_match[] =3D {
>>      { .compatible =3D "ingenic,jz4740-dma", .data =3D=20
>> &jz4740_dma_soc_data },
>>      { .compatible =3D "ingenic,jz4725b-dma", .data =3D=20
>> &jz4725b_dma_soc_data },
>>      { .compatible =3D "ingenic,jz4770-dma", .data =3D=20
>> &jz4770_dma_soc_data },
>>      { .compatible =3D "ingenic,jz4780-dma", .data =3D=20
>> &jz4780_dma_soc_data },
>> +    { .compatible =3D "ingenic,x1000-dma", .data =3D &x1000_dma_soc_dat=
a },
>>      {},
>>  };
>>  MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
>> --=20
>> 2.7.4
>>
>>
>
>



