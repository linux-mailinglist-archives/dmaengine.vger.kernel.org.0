Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DDE2DC51C
	for <lists+dmaengine@lfdr.de>; Wed, 16 Dec 2020 18:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgLPRPA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Dec 2020 12:15:00 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:46822 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726745AbgLPRO7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Dec 2020 12:14:59 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 34FC440150;
        Wed, 16 Dec 2020 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1608138839; bh=l4iwBI/wjSgZmtrnT09+BA9cXpRBIRFNradj3/AZ3KQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GVn0Q7khaDvJjiVoGkvprJ+AWwRjM0622LZ1T2JB80IaD85JaCU6/Eh7YIS6OUyLz
         sNdlxfPqGQAD8bkky5BPPW6cWMm+ODdCJ7wJNP76NwBwXkUyTbvvQU6HJo+kDSzIXs
         aNtFLAKQlspjZprBadfEJEX5tmp5D9GnKjg8odGCslxx2d2yxLyaqbUDfFbnHWapZE
         4AdDzblDX+IdKj/Ws1H54bIQEEYH3qZgn8CES6IMC/ibEsZIA0fD4eYCgQvmR4SffJ
         LJ3NT7mFYx379h9KDVGjMDRfc4TkMte4D294CkV7ESwrEtETTdKea1XjvmmZO/8Mrt
         KQcyUffdELdAA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C41B3A0096;
        Wed, 16 Dec 2020 17:13:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B8B2280216;
        Wed, 16 Dec 2020 17:13:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Vt4VJ8uY";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEAeelLIDywdEqA3BCu//JAx9eFtZoe8/FIiDwKiYoyK6D93jnBH9iyExMN95zW1r+0tZXToJF/+NqMaS7yhpWr3+8TBgyCs2jkUzVn94iBEybBKFUqX4z/xgLIZuE+Rn0O36UzfWBoLE7ROAkx85dlQqiE2M7IsVDLdZtmRYQ5tz6pKpporlHYCQoBmAGMoizCkp3qJogRBKm0WtmngdCp83CxVFM9jrXnwcDI7nkR1RWnQmXUyuNv/J1OTJzY4KFBNXL9COLZjuYVDdWb6y3RpM8ZH/HYmLzLRhOZnBrzwGN1nvP/2UwcaumfrCYg4FMmelh9TLTBPCxzzdaZCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSQm6g3UFfI7shTYQqN3w1q4819oDYCRDT5UhVOslcU=;
 b=ndkqnPwg4f3RMGt7Q344m93TQ1JV4WLU8PzjXGyFItE8976OVMTwJ7B4G5Si9Mi99NnR8bIRJuL1Gog1VfzqQS6AQ3DM4/ioop86225/sGaeMFGq/vKQpBWaCnyf3j8FXzxEiNkuXIpSZbCTftYtID24YXiPSNjAAqeoVs/X5ChMRg5UKHiURCZZqz4oqfydznobDwKej1348UXcLJa5qxkdgoBMQ9wTUGWJQ2w/O5mcY5xfx4ywwmAX1oNPpccZu578en+IDAeBY4icpqbaRGsrzOlG4BWQxMzT/+3OY824LThDFRfTrm9uQ4lqr4+RTqUOo+74T3FjOSEA3Umhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSQm6g3UFfI7shTYQqN3w1q4819oDYCRDT5UhVOslcU=;
 b=Vt4VJ8uYDObpwRIt+DSGJzFybQaOc32Q8ZL42XyONC3t7PllBmbIXIJ4d2MnDVv+hfukKADU7DL5gSsrX5v1u5MuJxqSij+5DDi3r1krAhQ2MIpYdd1/yKbG194wP88yK7JMPg5zLHZh2rPAS69OMT25Uchat7vknp8JgX6eFME=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM5PR1201MB0122.namprd12.prod.outlook.com (2603:10b6:4:57::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 16 Dec 2020 17:13:56 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::bd66:f00c:864d:7fbf]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::bd66:f00c:864d:7fbf%6]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 17:13:55 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: dw-edma: Fix use after free in
 dw_edma_alloc_chunk()
Thread-Topic: [PATCH] dmaengine: dw-edma: Fix use after free in
 dw_edma_alloc_chunk()
Thread-Index: AQHW0hCIFLxGUiywb0qhdK6UC17n6an5+WEA
Date:   Wed, 16 Dec 2020 17:13:55 +0000
Message-ID: <DM5PR12MB1835E4CC6D248D2FF0C48182DAC50@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <X9dTBFrUPEvvW7qc@mwanda>
In-Reply-To: <X9dTBFrUPEvvW7qc@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0cb4dc0-44dc-400a-89ff-08d8a1e5f84b
x-ms-traffictypediagnostic: DM5PR1201MB0122:
x-microsoft-antispam-prvs: <DM5PR1201MB01227F2060DC25DF9C2EACB7DAC50@DM5PR1201MB0122.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +OEx25HlM5tvy58u43Bi2vIau7rGpLSOaQ1mgnKM1OJTtnyZsKcq4tsuK9p3bswatCz/XGY2+jw9ciptzOI6Pdui177gzuI/iyXd4dwjuPGeFXhTEOeNSzRJ7b108E81T9w5p44uptnHu1d27L3/dwYarb7Aw521OZm8+fV8EeUJccjgGyWtzRZFTnPujXJFnngQmMR7lJqjv+fWk8Hgo080FJGoqMz7B6NRGk5j5R/kLWqFMarhSIfH0tFYPVwSY2tdHyi2izqoWcNbjwZOHbWqmJyegCoh2MmTxikhFY5M6G7w7Dy88/zJtG1IpMBVZUeOee+tUgqAuZjcNXl60Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(66946007)(33656002)(66556008)(55016002)(66476007)(53546011)(8676002)(5660300002)(8936002)(6506007)(64756008)(4326008)(66446008)(2906002)(52536014)(6916009)(76116006)(7696005)(83380400001)(54906003)(9686003)(86362001)(186003)(478600001)(71200400001)(316002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QJRJCq2eorhf0n1tHUB7eV2TDKSnD9n2KZp7DPz+ro/dikv9wwA3Q57/CTZU?=
 =?us-ascii?Q?MtLq5/w8xUr/52adXSiyXXrbPSYvPXUE5odTZ0hbQukdlxaIeux+wLmPbUQA?=
 =?us-ascii?Q?r73RXU51bL83sDFCJ6aEiP9X4xobNhU9oN/bQE5JPc7FR2kC3/LfoolL0Xi2?=
 =?us-ascii?Q?c1iHQ8Bl0YGSwc3SNwmJcZkJHlbKNOcJHMPCsOcOgw5tnN8/azlt2GULDUBN?=
 =?us-ascii?Q?KdReVlY0+dg9ZGs/n5fI1WTMUHWRqVotc235RckyDn7U1mxgShMGXvwI1f0l?=
 =?us-ascii?Q?8CPEmeLlz+cCTsjIn8IyuMChtiTw/KWvQ0aG7Xi7dfiXfYBgbOLI1b8/nNLK?=
 =?us-ascii?Q?hibubtwaYqAN9hSEtTteo1wyBtMD+mci7VHc6PqrM9C++JGMaz6HLos+xpKT?=
 =?us-ascii?Q?+mJ8tVetDi87Siw+EBncecnRbR1tWz3gHWOS3yxxwpo8HTW6Sko30/ZZOHzn?=
 =?us-ascii?Q?kSsN58xhqPmmt3QJRb0lFpdRDL/+JsC80UYCILcxV4p6111HCvQ3PVf8RKdI?=
 =?us-ascii?Q?jswhmyQ5sA/rRC43JEATxStbhuoOky9+sI9CTkqha5pgq9TrqaqZzsw0Wioh?=
 =?us-ascii?Q?/xLG2e/28k495tUUoTFj9hfVxNS9QtcqA9DhoNlfuBEJXYhpuMh1D8R5HC2I?=
 =?us-ascii?Q?xm41mr0eVVfx6qSWlxMhbD6r+JrAbJW3pHKGAsborqRkVXFUajBdtGX+op48?=
 =?us-ascii?Q?NoDd9wK73CpKCtjZA82uMhltXJOMUeJ8iPFOzzJfQWf894DUEtUvUDIJ39yx?=
 =?us-ascii?Q?gzY23nytkpzg5p1qlzfUP+4dX0i0Zje2gOMoBXLG6KAl/r76xm/bxhrbKON7?=
 =?us-ascii?Q?W3airZrRx1/FXmmktmn5GCMwabRk1D1UVL6wXuJJd1p9thrCI4rLXj33dqbu?=
 =?us-ascii?Q?htPEhwc9V2MmvhHI2JRRN/y94T9AYz8SkA/OzoCo5D5awuViveMH7g3Ehn+B?=
 =?us-ascii?Q?I57+yiAOv9DVolrjhO5bqEfbTOkJyqCmi9fJjLCpUW8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cb4dc0-44dc-400a-89ff-08d8a1e5f84b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 17:13:55.7068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2eLaUO9Fj520EtJ1rMAedp9m+dNi90HfatjypGo4GQbKkl5o8BusGYRpdrxNEFTIt1q76DgvoVyZ0tqtw+IAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0122
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 14, 2020 at 11:56:52, Dan Carpenter=20
<dan.carpenter@oracle.com> wrote:

> If the dw_edma_alloc_burst() function fails then we free "chunk" but
> it's still on the "desc->chunk->list" list so it will lead to a use
> after free.  Also the "->chunks_alloc" count is incremented when it
> shouldn't be.
>=20
> In current kernels small allocations are guaranteed to succeed and
> dw_edma_alloc_burst() can't fail so this will not actually affect
> runtime.
>=20
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Based on static analysis.  Not tested.
>=20
>  drivers/dma/dw-edma/dw-edma-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index b971505b8715..08d71dafa001 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -86,12 +86,12 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(stru=
ct dw_edma_desc *desc)
> =20
>  	if (desc->chunk) {
>  		/* Create and add new element into the linked list */
> -		desc->chunks_alloc++;
> -		list_add_tail(&chunk->list, &desc->chunk->list);
>  		if (!dw_edma_alloc_burst(chunk)) {
>  			kfree(chunk);
>  			return NULL;
>  		}
> +		desc->chunks_alloc++;
> +		list_add_tail(&chunk->list, &desc->chunk->list);
>  	} else {
>  		/* List head */
>  		chunk->burst =3D NULL;
> --=20
> 2.29.2

Thanks for the fix! Nicely catch!

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


