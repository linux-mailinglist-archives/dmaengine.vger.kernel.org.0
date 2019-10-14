Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9745D6354
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 15:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfJNNFc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 09:05:32 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60748 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbfJNNFc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Oct 2019 09:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1571058329; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Cso33BU+LspESyoe9AKCSci09qDYQ0jUSVOc4nHgXw=;
        b=Rq5kBat4RXxyaoTvdDshmtTMIiddGdqKjCadJXlQq0gdRfRRgX4je26CFC4q9i5TletlGJ
        jilJquTNt/uM7bTCG4g6ZTG+wbqQ+PvVyKq+7dWjAVDrYRhLX3WJqPLhRE36yPgxv8fHyG
        Qs+h5YBLsztRfRGbYcNIrTe2zZDO31g=
Date:   Mon, 14 Oct 2019 15:05:21 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] dmaengine: jz4780: Use devm_platform_ioremap_resource()
 in jz4780_dma_probe()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Alex Smith <alex.smith@imgtec.com>
Message-Id: <1571058321.3.1@crapouillou.net>
In-Reply-To: <20191014071400.GD2654@vkoul-mobl>
References: <5dd19f28-349a-4957-ea3a-6aebbd7c97e2@web.de>
        <1569353552.1911.0@crapouillou.net> <20191014071400.GD2654@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,



Le lun., oct. 14, 2019 at 12:44, Vinod Koul <vkoul@kernel.org> a =E9crit=20
:
> On 24-09-19, 21:32, Paul Cercueil wrote:
>>  Hi Markus,
>>=20
>>=20
>>  Le dim. 22 sept. 2019 =E0 11:25, Markus Elfring=20
>> <Markus.Elfring@web.de> a
>>  =E9crit :
>>  > From: Markus Elfring <elfring@users.sourceforge.net>
>>  > Date: Sun, 22 Sep 2019 11:18:27 +0200
>>  >
>>  > Simplify this function implementation a bit by using
>>  > a known wrapper function.
>>  >
>>  > This issue was detected by using the Coccinelle software.
>>  >
>>  > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>>=20
>>  Looks good to me.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> Did you mean Acked or Reviewed ...??

Definitely. Sorry about that.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>


>=20
> --
> ~Vinod

=

