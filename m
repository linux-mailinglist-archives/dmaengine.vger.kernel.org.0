Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46326C7602
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 03:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCXCqg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Mar 2023 22:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXCqe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Mar 2023 22:46:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F60C1633E;
        Thu, 23 Mar 2023 19:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679625994; x=1711161994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h4IRdJbDXF9ioZMKyI8TGIHO4Om5B+v35i+Ymv/d39M=;
  b=R+hgqIU15qX0x7UmhVu2NW8dNkc+dQXIpa7c3QyF2Q2Y8OczHWh4fcsz
   IrkDi+S2pE71Pt5zP2P19KcTkFvY/CqYnDWfGKNGR/AS4wFOavlmpQc3Y
   1AFbtq7X59dnjtAPI7jrm3YjkFm1/uS78CCqFf/DAIV+DQ/01PqPvFJR7
   4vFWpRBqAI7SbPGDZhtQniBvSlFbKcxOAzrph9tDNODXcYmwWv6smYl3a
   xzMejcDKBujEv//2a7l4W72nZH4QJQFyVXpuEYKdX5rhpPo7l83Av1fzU
   9OIj7s64v20Wpe3fVXH6R2kyb+9CO9qoUGVshtntl0OybrFMgfxNLoE4w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="341243242"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="341243242"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 19:46:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="632673676"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="632673676"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 23 Mar 2023 19:46:32 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:46:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 19:46:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 19:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFqOnpF7dG29thejHxESdztGVKHNqj9Q/xojqeSFdXJItVzLehTcSzuAcmM/oFFB+KOQklvpzXnaE36tL1Czdy6STRTr+QPd1b8MZQ6q5KPHyJTbA07EAjGZQeFePIuZk0rpaOlO8bPD+lsrjrAu1GEUrw7ZwQlL2wweN0pNcXNmlAgrEidyOk7+6j2qmc3Zc5GZ4ye60GgwnL05/eEhszXnobe0iIS6Sn8hXKrH/X1bYd6pnv/4JgKOLx5fTM0VG72FZlQ9il3zLSth/2/AL1sdQpAAZDRtDtwnxxCoZXk5EXGGr5T6QTXLE2RzPO20Xu3IwY7PiG1DWYTkyceuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4IRdJbDXF9ioZMKyI8TGIHO4Om5B+v35i+Ymv/d39M=;
 b=oL9NzRCTZ7puET8CzgUMa18kKVmjplwObh559a/9dA0U0rGapuLSI12rdpN6eU5juLAO6lIQtUTkdas+5MU/5QqDUAmZwzFsMX0D+aNBiRTxToBYHKhemSqD93GPPbUZhVWTq5vfA/tZsQQaiogQtt5PcxXNyC6ktKIvSzC/HrbqU56x1yNSKTvuxjdzpq51aI43z9ygD43VjtLj9jWhfsf4F7Wz84W2hnDLwsWIXMHuojoT7DlSTIq8tzdWCFUF/XARkQ93PC85iSYXUKSBu0JGL7YNNx2cV3IvvZSThoN42cYNE/YJpnNKfAACSurqRGyt2qvN2/2yIV90q208Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8363.namprd11.prod.outlook.com (2603:10b6:610:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 02:46:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 02:46:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v8 4/7] iommu/sva: Stop using ioasid_set for SVA
Thread-Topic: [PATCH v8 4/7] iommu/sva: Stop using ioasid_set for SVA
Thread-Index: AQHZXPl9KrwHo5CG00WWZAeW07uOC68JO5rQ
Date:   Fri, 24 Mar 2023 02:46:20 +0000
Message-ID: <BN9PR11MB527690AC327EB7E2F3EC5CF08C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
 <20230322200803.869130-5-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230322200803.869130-5-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8363:EE_
x-ms-office365-filtering-correlation-id: 849ee88b-a65f-4123-d504-08db2c11f32c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dh6YpjLBtCNqOaVkRCqFN9nsp1Aut3gNQlhpieb/Fa5z0mpePSAfNqwVD+2cG4Dam4qiDB5K0NENpdhXFmJf1uaL+3lvOz40bCz/M5rE1NbDV/x7tselAz5x1L4DY7QiqqV5odWyTztKaTTzx08EbxFSvNiZKZ2WEseXszT90aXVV+NT602ocEuS/4JY10/NAK9BZIR9124xLc2V8B//ryW7WrIrpKN2KRjCc6F5q6+4nnEIKIgDR/MGC4gNQPIFERMhh7952VIsFsmvPvLSv2vgeK1IICjrFVFX07OzTY8T2pUjF3VqovDKP08GNOtfivtU6bic6Kv9AR9Vl1s49lDh0HJw4HrH2vsAWaWlc1hRApdgfe2PWXSRcj0sSOwP1hFgAfqmiWXevSnjs68BCt1+gXF+WWeo9VhD90SelklUgl3nQsA/J6IH0oVroobMLxXOBBbytR1cSunI5Zh3VX81WJPsUagfCylUr5Xo/dGGYZaKVCFIrZO+I08ngxIu5e+BcubQmc9l2+UTpkRxWG/hHZjq77n2Ag2Ls/glX7OosWY4C0R/MNb6B1ZIkbhpqt9onHH5MgaELO91jRtiVnVcJJUapOr+zTg2Kk2KJS90BNQthQShVqNCUTGBVeo8lUrvXtAXy4+QRy9meagOPI3h0YDU0LwRWbrVBPgp6PmIUDVTpLcRBwxhhdOezP+kbAiQARrsON491BSVa4pwycS3lMx7OyorU0faKXeVtU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199018)(38070700005)(55016003)(921005)(38100700002)(2906002)(71200400001)(478600001)(9686003)(186003)(86362001)(33656002)(110136005)(7696005)(54906003)(76116006)(64756008)(52536014)(66446008)(8676002)(4326008)(66556008)(66946007)(66476007)(26005)(6506007)(8936002)(316002)(4744005)(7416002)(122000001)(82960400001)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DFLphfSnBEZRucAydiFfw0omTpJpDZKh2YDRtZr39QAEdUtQVmg4ogq4kQcb?=
 =?us-ascii?Q?/cpFiDoq+4lzcLJs4Utz3CESq19MRDxINRCnT+BPqT+XwUvjNzgCF4DVcKYl?=
 =?us-ascii?Q?Y84mZbXwJwub06GBT3Ewj1PtXgxXQ3btAs2UsnJpj7AS8Rb+yCnigZ8yLqH/?=
 =?us-ascii?Q?2q5yJmIH7TzKxlJWWGkunTqCwCP7OYZcbugAwvOmBGMy/Uxw4o11CGAL06DM?=
 =?us-ascii?Q?BEO6EmHScyoo2Fod/bsKCQ6VBJGCt2AMIAcKDNUYZSkmH71QkwqDfX0xvfWx?=
 =?us-ascii?Q?0EXZTzIrxz5K8vI6Gabk6i/Imwy9P/ZNSA4Dg3eH/yS1IuV5nDlIr0xlYMe2?=
 =?us-ascii?Q?LUYstN++0Xw5nrRQf3lT4O4A7efaccOuU7qXEioTP40VfoZr+FuG8F+DT+ye?=
 =?us-ascii?Q?nvWdrNZlhLVbj6LntLKUkfsjcDxB+6UtNvqSkrHCznTRr8iAlPCBOToBrv2f?=
 =?us-ascii?Q?luXNhp/R/E98rT8LRWedZTsQIvUyQPIEQCBy67KxI2tHHxvHrfuyUlnzKxp/?=
 =?us-ascii?Q?AR8+pU7mffZTrFA6u4E9Gs9HPp+C3+PHwCKaAXoy0bs35XbEPIl/nHZKxrvk?=
 =?us-ascii?Q?AOFehE0P1s3ET3m6YwHObOYhJ1447CDEGTO+WW7acNw7j1i3wI7Dtcc9xQI1?=
 =?us-ascii?Q?F+OQwMG76sDv21buNdj/P75dvyxgrvvNX4+oiyDuv5JP2y0Jkq0RYS3L9Ul8?=
 =?us-ascii?Q?ZYdzdQ/iBGHVUit1LC43AKapoSrqZkZs0P0WSkPq5jIoUtzwM7274yhcgPQ3?=
 =?us-ascii?Q?M1GSge2twe3Ica2c7RNVRx6D7fGKG4PBy10BP261S1TwX5JBDvfkkh7sWBpZ?=
 =?us-ascii?Q?01W5gEXQfOyjsC++CuwEoJna/98NG1Yn32OXQFJQTSCIgg+WS3rrjXrNzEU+?=
 =?us-ascii?Q?4JeJWhhJexnGhPOvZn9qUTaFhBF4G/MOP4Y3x+RKfcCuOmQ901HtgYFSnnkN?=
 =?us-ascii?Q?swnCDuguuI98+2WGJrT9l1ZxlwQphgZiN+t1Me+EkosjKrxraaPY8e7Zaiiq?=
 =?us-ascii?Q?b+Blqh4gtJYTxU6K7UpxrY3OrM7ErvpqtzNriULFtmIZ5mv0W2ROqBA9RTGj?=
 =?us-ascii?Q?BkJ7Yjn5Jezn1yd0Wbg9Qu4QtXpFyb3dsvBy1L0Y+SMpHMIX5mqBkqPAMkEZ?=
 =?us-ascii?Q?fteLmLdYIqeJuZjE8y8BKLQ5PSSo3je55J57Iv2dEnQGw8vbRVjEN+xH8f/a?=
 =?us-ascii?Q?fJVN2Y4/GhnwR4g25qfKvJ0BbtHXoraQgXLAGq6DsXYB9jcy32frohvhiPPX?=
 =?us-ascii?Q?UhQTducZdLP9SJzuLCQIeHzz0AcAIBnUOGaGSUcHcuib8AaawvjEQ5upm2eZ?=
 =?us-ascii?Q?G0CsR6saYeAHZwEF7nynO5GxFP9wDHG2bzHHH31xolZn60etmYR0EzVhII2Q?=
 =?us-ascii?Q?FGKHlDHmJvvQCypFZcgkJglW9cdgnC1SJ+cmcE6goG+N0F4ns9usAD993viu?=
 =?us-ascii?Q?tgm54Ft12k6oZE3ESb1WQMtlwKSYPe8h1Qy7KQx+DYdYnK1JpUTe7aCp2i9g?=
 =?us-ascii?Q?SjLxgMwlmfcixPL9hYOkURMWvAgFQ4qGx2NTN/ebMoOR6KljDfnk4+mXoHv6?=
 =?us-ascii?Q?s8ka6lYGORuhMm9E5Fd8UCml1g6V1X7Jhe0NAaEO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849ee88b-a65f-4123-d504-08db2c11f32c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 02:46:20.8768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOV0mz5cR1+jRYX5u8/IS4zVuFXpCWYsfDagYkXa4Bkaw4PVCIPSkjI5VjrXckqd6OG2Bn7BeEj3WXvVE+RX2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8363
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 23, 2023 4:08 AM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> each mm_struct.
>=20
> Future work would be to allow drivers using the SVA APIs to reserve globa=
l
> PASIDs from this IDA for their internal use, eg with the DMA API PASID
> support.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
