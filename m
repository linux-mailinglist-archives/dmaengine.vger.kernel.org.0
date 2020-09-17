Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D941226D818
	for <lists+dmaengine@lfdr.de>; Thu, 17 Sep 2020 11:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIQJvI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 05:51:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48748 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgIQJvI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Sep 2020 05:51:08 -0400
X-Greylist: delayed 678 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 05:51:08 EDT
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08H9dP40115953;
        Thu, 17 Sep 2020 04:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600335565;
        bh=ApfJt1f1R3o1fVJIvF2kAu92MDXmu2uUvIr6aN72G7s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iGGygCf45YCV1tGUAh2OT7fdwYhG9JqvNbBKrVkX4uXDmhdZL7NXl+/CqOkx4acBD
         nN3vNedlTA77mE+J/hsHTup3/X0L3tJU+famgz6XYJ412I1cQagQIhq2wbmF20qOWn
         uj/uIW3bWuIaqExqJTz8QtDlI7GS3vCTGivAmkrg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08H9dPZj041855
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 04:39:25 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 04:39:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 04:39:24 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08H9dNP5048362;
        Thu, 17 Sep 2020 04:39:23 -0500
Subject: Re: [PATCH v1 3/3] dmaengine: dmatest: Return boolean result directly
 in filter()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
CC:     Vladimir Murzin <vladimir.murzin@arm.com>
References: <20200916133456.79280-1-andriy.shevchenko@linux.intel.com>
 <20200916133456.79280-3-andriy.shevchenko@linux.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <5d865914-5481-0fe8-55d1-0c8efb6c481a@ti.com>
Date:   Thu, 17 Sep 2020 12:39:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916133456.79280-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

On 16/09/2020 16.34, Andy Shevchenko wrote:
> There is no need to have a conditional for boolean expression when
> function returns bool. Drop unnecessary code and return boolean
> result directly.
>=20
> While at it, drop unneeded casting from void *.

my test scripts are working fine with the three patch applied.

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Vinod: for all three patches ^^

Andy, Vladimir: thanks for the fixes!

- P=C3=A9ter

> Cc: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dmatest.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 757eb1727a04..cf1379189316 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -1070,13 +1070,7 @@ static int dmatest_add_channel(struct dmatest_in=
fo *info,
> =20
>  static bool filter(struct dma_chan *chan, void *param)
>  {
> -	struct dmatest_params *params =3D param;
> -
> -	if (!dmatest_match_channel(params, chan) ||
> -	    !dmatest_match_device(params, chan->device))
> -		return false;
> -	else
> -		return true;
> +	return dmatest_match_channel(param, chan) && dmatest_match_device(par=
am, chan->device);
>  }
> =20
>  static void request_channels(struct dmatest_info *info,
>=20

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

