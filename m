Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952B521828A
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2020 10:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgGHIc4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jul 2020 04:32:56 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48568 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgGHIc4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jul 2020 04:32:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0688Wjrg052399;
        Wed, 8 Jul 2020 03:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594197166;
        bh=im48yA+Olpa0PxVY1qxOgHlM9ULgxzinTKCtMKJsIRM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HxawSnpd0qA2WEzkWEjO+vSQPr2aYWM5RkDw8OZvq1IK8Uc72dYdqjt71qknpM0uG
         ORM7v6ehUlxb7AX/cBAx73xdBZu0UDy4xpt5XB0XoJReGJ+yF7mlZGVqTv2Iede7cS
         3iHgolg+qxlIsNcsnI3jjecK4Zajs+1E8ikeYekg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0688WjpO088024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jul 2020 03:32:45 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 8 Jul
 2020 03:32:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 8 Jul 2020 03:32:45 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0688WhqR095672;
        Wed, 8 Jul 2020 03:32:43 -0500
Subject: Re: [PATCH next 0/6] soc: ti: k3-ringacc: updates
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>
References: <20200701103030.29684-1-grygorii.strashko@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <c281a799-6a56-ff1d-fb87-a54f85fa125a@ti.com>
Date:   Wed, 8 Jul 2020 11:33:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200701103030.29684-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 01/07/2020 13.30, Grygorii Strashko wrote:
> Hi Santosh,
>=20
> This series is a set of non critical  updates for The TI K3 AM654x/J721=
E
> Ring Accelerator driver.
>=20
> Patch 1 - convert bindings to json-schema
> Patches 2,3,5 - code reworking
> Patch 4 - adds new API to request pair of rings k3_ringacc_request_ring=
s_pair()
> Patch 6 - updates K3 UDMA to use new API

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Grygorii Strashko (4):
>   dt-bindings: soc: ti: k3-ringacc: convert bindings to json-schema
>   soc: ti: k3-ringacc: add ring's flags to dump
>   soc: ti: k3-ringacc: add request pair of rings api.
>   soc: ti: k3-ringacc: separate soc specific initialization
>=20
> Peter Ujfalusi (2):
>   soc: ti: k3-ringacc: Move state tracking variables under a struct
>   dmaengine: ti: k3-udma: Switch to k3_ringacc_request_rings_pair
>=20
>  .../devicetree/bindings/soc/ti/k3-ringacc.txt |  59 ------
>  .../bindings/soc/ti/k3-ringacc.yaml           | 102 +++++++++
>  drivers/dma/ti/k3-udma-glue.c                 |  40 ++--
>  drivers/dma/ti/k3-udma.c                      |  34 +--
>  drivers/soc/ti/k3-ringacc.c                   | 194 ++++++++++++------=

>  include/linux/soc/ti/k3-ringacc.h             |   4 +
>  6 files changed, 261 insertions(+), 172 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc=
=2Etxt
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc=
=2Eyaml
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

