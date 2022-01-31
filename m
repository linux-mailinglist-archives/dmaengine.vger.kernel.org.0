Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BDD4A3CE7
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 05:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiAaEZR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 23:25:17 -0500
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com ([40.107.236.86]:41952
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229572AbiAaEZQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 30 Jan 2022 23:25:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCGcvF4kVcwXpssiEu37fOby4s0zCFqsMYVojPTuVsDc/6ulNG2QANoCJZ/oBX/LtcYwnoY2Gc7XCGN4XI06K9Nq72pgy4uXZb+Yo+VI/cTNneQ/SzfaJ0Wk3TQAMhOcJLiZQA/3ip6yJ8NeW3DXzM33CDtnQ/Yxxzzhgwqsn7yz/4KCL/lyClASTR0qfMpgoSLp6Qwgm9cSYil3WPwpbXb5kurki3VBTt6t5ifBmJv+8eWW6DiEWU+3UAvQMIst9bGNFNhPywxLsIIDzrlq0FNRLBrt0PA9JJ4FRDldHNQi4WbAKSysGz8UT2sh5fMS/1C5fhVh+Lq7vdo71add6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei8oHUbMZWZe/xl6AjB49XZDvKC7c7Yw/00ClGSlm9M=;
 b=j37YRbOcgi0R2nF77HL6wZadNxgQoXGaWqzaI+x9ygGTjp+dMCXrS+5QbtA3L0glq3N+gscFKGuq6uDVz67/0P+uBddzj7xIaGDCMJQfyLSF+4wWzUlC5d1SVT6kqZw+aARyo7+/gyGgOUZsNOjY9SyaCQKXwVewfUSQMF5XbSOwWeKvr/HMl09PupvU4s0pwWHUVs5szt3Sz48SLmsWYSNVgL+ZMs80arBMblDTWy+mO8xARTQKlrl8T1Vem88O+9fRdgKH+k3zCgsLgywiTdtpF13ZZw2NL2U265R2rV6OcoyzcRZvAUuNTldcA52MsZK0fK0jEd7VZE9eOpM3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei8oHUbMZWZe/xl6AjB49XZDvKC7c7Yw/00ClGSlm9M=;
 b=Xx0UwSKf7di5GjniCtiBvh42awddutQgSFVRxT8psG29GaMyhRHi46hS6etohEuZkuvKt2bHeNyUfVF+XJd19fMI2rsVI3X0beVoYS8A2XFGWKAjUtkrB56LrIahRMlQxue6XFSU1sEfaPlpI/6S0rTJ8LMc42agjA0C5lVBXqdaAfEnwYSkDINciwVjs5NVDske69CYf3lFuWbF6sB68E9RUR44L5pSgXM3a1vruzk5zgQfhJ8dN42Pobphw4HypDyCilbge8yBZgNj2Fw+/QrfthdJKg5BxB9g5vHXpSWLbzWd200mphjSsff+eIuqv0kUGB3OKXwyH7zaLkhxDA==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by DM6PR12MB2652.namprd12.prod.outlook.com (2603:10b6:5:41::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 04:25:14 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 04:25:14 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYFS8ttZm9vnsYMkmLjfwGSkse9qx7V3sAgABn8UCAAHOwgIAAU3Iw
Date:   Mon, 31 Jan 2022 04:25:14 +0000
Message-ID: <DM5PR12MB1850FD5F3EF5CBFEA97B3611C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
 <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
 <DM5PR12MB1850D836ACDF95008EF74CC7C0249@DM5PR12MB1850.namprd12.prod.outlook.com>
 <08f6571e-af75-b6b3-443e-e86e3bdb365b@gmail.com>
In-Reply-To: <08f6571e-af75-b6b3-443e-e86e3bdb365b@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71aa7512-b1ac-4cbd-cc08-08d9e471adae
x-ms-traffictypediagnostic: DM6PR12MB2652:EE_
x-microsoft-antispam-prvs: <DM6PR12MB26525673B193D6377B3BC03CC0259@DM6PR12MB2652.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ByEoLAvmIR4fl27VhPW1Sa0ZAX4PRRK+8ohLNRMJmoKTSUqoEH+vkkY1w1InOOQkjx5ImJzroZh3QDh+8fvhMmLHny0zqFlGMTpyaan2ZmiabEF6FX7M4FpvofPDoCJKBIwneFx2/cMXiVYRUukAPSYwFNkGC51XmLSVp9tx4piCk9FEN2y4hjjrn4qFZZB3I4hWL2dd/wePEMEpbpSevsLiwM88SQpHU5SjRYdG66cvA4/MSXCpTqg4slOEaxusZNLTOs21xViEkLJRfVxhCoA6jtfJJoXrVkdgjUszHCXOBWHtecv8AoYFiod2roMSfyKdglzVrqNf3L4PzaEpM7dRQ2cIFpK6iKF88sF655C86E5YqodyIQxLzaZbBEWBt+pZ/L1nwQmMw2D9i2TaCll71Ogh9Gz06Y6WyUFhLapNrxeQgGuCFoB0omKSA3Roo8y/B8B/G2JXMxfU0/TkP4QABN9PEfnzBHNMqTTKvPTMcKD8OJsne2y0tK/GI+oEdyQLKw/blXTcCtmJHPvXtx6Wb01audNZJeqBS3+R12TcdNl6UUnvqWTROatEd8hg+RHh9M4EgA6uHEtKvenTW0C79z6qnsWkZvoO8eZWrT3LVMRfowBjWuVnKJoQrS9Jdbdwd+uvuN7s+Tf5DNa9jIipBDeiFK5NW9FysxNpf+gdFMxaYrtno4j/7EM9FV0AWO8H6o7+t/RLLQRHCSMhytzggnkt/A377s4XWGzJDHI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(7696005)(6506007)(186003)(55016003)(508600001)(107886003)(26005)(71200400001)(110136005)(86362001)(83380400001)(33656002)(316002)(55236004)(52536014)(921005)(38070700005)(5660300002)(38100700002)(2906002)(122000001)(8676002)(66446008)(66556008)(66946007)(8936002)(76116006)(64756008)(66476007)(4326008)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?89dh3pidkUhnY+CA3C8XaXnbMWU7DEvMP8RyE5mWUOKRG49hwpv28UO9LaCkLx?=
 =?koi8-r?Q?b/02UnOLXcx1iXxJsbq+zfKCLyr0IrO8YG+9rrmgDnH3l2QB1bTVFpMS9lRxSL?=
 =?koi8-r?Q?EsTVG6nKYqMQM1z8nP5FiuxnzAeJjBvc2EjZ6f86B84c6KbWCQfBalPBtsDKkq?=
 =?koi8-r?Q?HQaIHbyO2KrWaPh/geQBAkGGwlDCCKAXNwP4NpQ+Ry3AoxSMxQ4PxDG2QI+GUH?=
 =?koi8-r?Q?hPe2dYLvy1tpdV0aKZf24LgZxha0zZY2rzzayqaHcGBoahpz6Z9mhI9vwSf51C?=
 =?koi8-r?Q?NT47s3ZgDPkLi7urGIWRXVCK3P0lHehfzRAwZfyW7DL1WyFlWt/KnAp0/YeZkI?=
 =?koi8-r?Q?/gnmKWwe1gccUnZfaypYDdKqqKzV+cDfcHoyM8asZF4jF2dsvJ86go2GYXQyz+?=
 =?koi8-r?Q?kMnlln/mBpTytnC6rfbD1wIj9kOXonJxK8B1SbXzwgk0KWQvWy87WX+bsUQMLn?=
 =?koi8-r?Q?ziDTTjkH5Fo6HtT/Eox/iRHzAf3eme3edpGDaplgfMUOjWJHG/uYZLIvTbIc1e?=
 =?koi8-r?Q?DnASfU9f8yGZHxkAK1a8TvGueXmqBu/m76UzG6txTi837ryJ8gYvv9Bo3CtyM3?=
 =?koi8-r?Q?RH2WulqTw0lcMX1QW0kiWxMEGs1HxJ1zoNSqbX4nStViFcCmutARgts3eHy0HJ?=
 =?koi8-r?Q?/nJtE57t5oxF5PYe1Q5G8C1dKdiqDiGriaXsMQ8LS9t0PXunCEmO6l+FCy7PIq?=
 =?koi8-r?Q?u926tn5eJHpBt6l+zThcjqmPtVLISGxZSPEfFqAFMQb/vANI7Vdkyhi8j7NAN4?=
 =?koi8-r?Q?NRcENcHnASznjhopw4wKGoJ9ToIoiTxPSAZ9BsHt8+c7HPn5LbNRHE8cI/Ujpk?=
 =?koi8-r?Q?hG/FmTKdqsISj+S1V5feQ9ljVNaFFbncoiAO7PdaY/M/D0gVLMWNu0JCs0UwJZ?=
 =?koi8-r?Q?JYOq0gtftJohLtw7g1niJ3Z7uRANuj7Fzn5Mc1anGygMRyRp7VYIIXLbRIuOaq?=
 =?koi8-r?Q?w5SAK+0Rwf3EoDiVVRUh/KZtT8dO63TmVNb/3rGmX85bVeN9L6uc3mmQcId3rE?=
 =?koi8-r?Q?plhgTHhpyS9R7sE56fbSqXCgoP6/E5nFQs/ogd4Ch5iqrkqaRUow2pafomPu3z?=
 =?koi8-r?Q?m+o8flcXl7tRqYjQHHZfPCjjwGw1ikmk2F6gMx98ev0de2etIpQ72J3PAQm/ko?=
 =?koi8-r?Q?WIgiQUYIc9ZiatrGhXvX8CmbnCftw0KBTxw43I4ju/EDRAqEowLTfii19bRoKF?=
 =?koi8-r?Q?eIDFIOm56k3BbOgloF4X/ts8Zxem/I5u++N9v6AKN+s9y3JuPmB/+bXnEkbpl1?=
 =?koi8-r?Q?BBOXke3b79DwZyhH0GQY30KaiTE7aTGzf68oSUXQZVZYxVEnWRXUpPJeS8U6cA?=
 =?koi8-r?Q?6JWE0omW2BKXcp1kJmXRRpaAKrCfMFqIqfbzMBDV8TAcYF7gMU7IsQaxkLaC6Q?=
 =?koi8-r?Q?cgmgQXXTzwfeGZ0i0pBFdSGlwM2qlPLF0jEAFg5CClI5WoO/MSoNie254yOTUF?=
 =?koi8-r?Q?+Q3hbWZW1mWG4fwNXBqKQBokqt/Vxeu+y76nP4OKxJqG8aYsCUvW/mGJ6gbDzb?=
 =?koi8-r?Q?2hc+ryqNery1K/7hiN4sDmoanCpLc8wkTdACf9zk6CVQyFbvIrGzJl/y+epFL+?=
 =?koi8-r?Q?vO1L0Bc2izYwTvG1jPzaj4AeD97ldUY=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aa7512-b1ac-4cbd-cc08-08d9e471adae
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 04:25:14.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5991FLyTDouc/DL0VONK8gJs341qXJTpKg8FkPSBCqzndbOP9DGXT34pU6sVWH9CjO9WX8C7BvFLH6PdHG0ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2652
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> 30.01.2022 19:34, Akhil R =D0=C9=DB=C5=D4:
> >> 29.01.2022 19:40, Akhil R =D0=C9=DB=C5=D4:
> >>> +static int tegra_dma_device_pause(struct dma_chan *dc) {
> >>> +     struct tegra_dma_channel *tdc =3D to_tegra_dma_chan(dc);
> >>> +     unsigned long wcount, flags;
> >>> +     int ret =3D 0;
> >>> +
> >>> +     if (!tdc->tdma->chip_data->hw_support_pause)
> >>> +             return 0;
> >>
> >> It's wrong to return zero if pause unsupported, please see what
> >> dmaengine_pause() returns.
> >>
> >>> +
> >>> +     spin_lock_irqsave(&tdc->vc.lock, flags);
> >>> +     if (!tdc->dma_desc)
> >>> +             goto out;
> >>> +
> >>> +     ret =3D tegra_dma_pause(tdc);
> >>> +     if (ret) {
> >>> +             dev_err(tdc2dev(tdc), "DMA pause timed out\n");
> >>> +             goto out;
> >>> +     }
> >>> +
> >>> +     wcount =3D tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
> >>> +     tdc->dma_desc->bytes_xfer +=3D
> >>> +                     tdc->dma_desc->bytes_req - (wcount * 4);
> >>
> >> Why transfer is accumulated?
> >>
> >> Why do you need to update xfer size at all on pause?
> >
> > I will verify the calculation. This looks correct only for single sg tr=
ansaction.
> >
> > Updating xfer_size is added to support drivers which pause the
> > transaction and read the status before terminating.
> > Eg.
>=20
> Why you couldn't update the status in tegra_dma_terminate_all()?
Is it useful to update the status in terminate_all()? I assume the descript=
or
Is freed in vchan_dma_desc_free_list() or am I getting it wrong?

Thanks,
Akhil=20


