Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE092DA904
	for <lists+dmaengine@lfdr.de>; Tue, 15 Dec 2020 09:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgLOIKf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 03:10:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:56362 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgLOIK3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Dec 2020 03:10:29 -0500
IronPort-SDR: /taIdlDZrkWXUJj1ECS6Syfg04UDhUEb3hETU9dL44fOqZzzLTBkkD2tkKXg9MgnmlRhB9+QLA
 SC3cH83W9z8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="259570030"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="259570030"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 00:09:48 -0800
IronPort-SDR: xYk8ORQflqIE+wMI1hsjP0QAsQmrM0hDKbDmG2NlUwmApiTI4Ll1W1t/mY7RJRgyGhhw8JhiVQ
 c8LNJAEx0ypQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="450975558"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2020 00:09:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Dec 2020 00:09:48 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Dec 2020 00:09:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 15 Dec 2020 00:09:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 15 Dec 2020 00:09:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKB+qi3/eUtPq3+9tR7NJB9RhBpCwuoqXWqQKRet/8eukeL63IY7DpRf0S8fpgxgcgqkQAHwW8LIneHTeviOk6TbDQFDDkkKz9KPdxfiE5hK62+59t55g2avMXymya/D2zyLnKtewepz7vbw66IZUB1WmKU1lYenZzXwSQGZzjbRLdgbBWCg9uKcRa3Ukl8LCH4Qlsu+zOAxbfTworCd4i/c2IP9KfAB0SFkU9MIxmFC01Q5bAg7GN2zw6S0FpvLcS7PxUfvS8U+0mFFd38aUMhL8U+zHPJkOfXqru12sfXautjbPQs5tr/rPrjUudOEjSj7gxzqzmDfuGEzi8NCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIQzTDdMODJhAbNg8auyIY4EoWL8S1d2Jd4C46gPk/k=;
 b=ERjrdpq8GIuMrVEEy6OISKWxo931f5OHGhIvx5mqrXftvkE1B2Udz/djvqizoWcMtM9s0R2Lbagr8qoIOpOwmJf9fRSLMUtNwiP+4Eq64pmsNgDcDiGr8GYZgUOpRzGjtvO3VeaN6worimPUEGL/njJeTYujNI0d3KB3+tww4RN1nC38P1EML/isxLzqxokM6f1/uOIhBe4Ah4581xMtpqI4BwCIvgE8m+Za90hJtDQumKbFazZ1ZJ5T4sVBnayWQqFaAo8KXWKnuJsQRgkhUotV1IBj004gBQZjkqL/wz4vHBrbpooul62mgwFhWJcFq0eOH9ZLvwLPWSdjFY/QIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIQzTDdMODJhAbNg8auyIY4EoWL8S1d2Jd4C46gPk/k=;
 b=Pq+BNPmEwAWzcwxdHrGqorVz4XfbqCRIZcmM+eKDGXQwa3/+NHFnWVsn3TpPLG6KW/ti2lRRaQ8trQQB4M3v+7NxwPSJL5EdnPULrfX/nsxyuQyaZnLzSdAqefaq8nTokWAjcSB8Fg9zBa37bocnDOzJo/4cT1nmp4gnP6ulpYA=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR1101MB2208.namprd11.prod.outlook.com (2603:10b6:301:4d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Tue, 15 Dec
 2020 08:09:47 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 08:09:47 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 10/16] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Thread-Topic: [PATCH v6 10/16] dt-binding: dma: dw-axi-dmac: Add support for
 Intel KeemBay AxiDMA
Thread-Index: AQHW0mvc6aoO4dGCnkyozignSSXE7an3zkVw
Date:   Tue, 15 Dec 2020 08:09:46 +0000
Message-ID: <CO1PR11MB50266EC86067669AE02047C5DAC60@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201211004642.25393-1-jee.heng.sia@intel.com>
 <20201211004642.25393-11-jee.heng.sia@intel.com>
 <20201214225239.GA2531399@robh.at.kernel.org>
In-Reply-To: <20201214225239.GA2531399@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60f74aef-df48-44d1-fda0-08d8a0d0c9b9
x-ms-traffictypediagnostic: MWHPR1101MB2208:
x-microsoft-antispam-prvs: <MWHPR1101MB2208CFEBBF488D4B1054B71CDAC60@MWHPR1101MB2208.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +JShYASy3Zp4/QYM7VOp0sGLA/rMf41B28D6tGT9C2bu+eV6SV5wjjbKPBFUVk0EeY2pOXNjPjFqivlt5KZifrrFF5nIS2o6T8mGu7umWw82FV/TJFyA8WEF0S5KlJsYZT3StVTWg2m3Mea81frHASFaAMBvWKkNo8k1cv+kqyIXh/hQkcOewfqPZwpw1cNJ822Qpq1dtk5U8qBD/odBJshfA0bM9veD9CfkoVA0qgyTFbDI0+wrNeHk9iq/7RPWv7Day/vmtJurA1WkWgnDjBfbOeCAASsRY34N6YxSeRFrS9W2zE8qhPJp0NYTd4Iw9sAH7vKKsod9IQ5k7SyFlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(186003)(66476007)(26005)(53546011)(86362001)(6506007)(9686003)(7696005)(508600001)(55016002)(52536014)(33656002)(71200400001)(76116006)(2906002)(5660300002)(64756008)(4326008)(66946007)(83380400001)(66446008)(8676002)(54906003)(66556008)(4744005)(8936002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wS9GXyU4amxeBhHXqyqwiIDFidhfYsisV1QVUJrJ58YLDOzn+xv+mbim1Mmj?=
 =?us-ascii?Q?smu844BUKGZi1RXPlZuu2tq5oncuBD5A/F1eMlLmsApyCepnCo3wAWnsJ69F?=
 =?us-ascii?Q?LHDY0t4d05xBmmTSuEwvLDiTV+D/s0DefQi7krRMVktO5lRkjRsylizEzTLD?=
 =?us-ascii?Q?/r4DY0GLp3ldqo6jNwe9KeAli6AaA5+2T9/Z8CH9IacmG/hkRG+jCs3knPjF?=
 =?us-ascii?Q?bJ8DqRVmp350vf5a7W60DqBhBHdqWXI7PGauxPc12bd5BSrMHAa5W+ROJK+w?=
 =?us-ascii?Q?lA11IRIhKhUJiR1ksdo3fcomXADdBIFsp42ajvJmRmrFdFPXSxESToiCCztz?=
 =?us-ascii?Q?jlMQ7hnF0QLmQAcYOP2qMn/MeIsNNmWhL5STZEyBvXE+fUI78EPOJ0PbDFnp?=
 =?us-ascii?Q?YvhpfVkbOQCWa3EHubawhKH4gTq1Jvji15cvvJ80aBN4Cq0ff6V2moGYT3Qs?=
 =?us-ascii?Q?Yo2NuqM5I6SZj+U7pvbQhm/GIf45Jy8XETgumtoVx3VWEghik8xEZkJMU7jR?=
 =?us-ascii?Q?R9VdIBXJDrcPyH1h7LelSb1eb0LyzNgZSOtDgRxaAAgU8uYxqUCyLWe75KKp?=
 =?us-ascii?Q?bBtfHDo+8z1NqpDrpfnHhpAVGwmqEvZBZnjMnXMI1kZLrd5FMBrm/CLlpy8F?=
 =?us-ascii?Q?WM9Ur3nnCpHpwrHWMQwUQzcF0frZwDQ+ahx1cXgd95ZAR6e5N9K7hdTIXewG?=
 =?us-ascii?Q?UftJxESAthWAAWNG/uyUDpxKg5f7GKKPIXhSdSIpIoyqmjlrJOexWQ2uI3a6?=
 =?us-ascii?Q?lJ2fj//jzCRYS3VEXBgBGy7GJ7+pJ9+qmMitiVcfYNBcepODbGvcAaZMqoY5?=
 =?us-ascii?Q?kIBLTWzgd4PNqCPDT4LZTZuFByJ0+C3BMAPIX5evhogkvYkKkYfDcjOCmOlL?=
 =?us-ascii?Q?QYAIRBFQuSHUpCBZNFUuVx0kmVpq+iYP+bWFXXr76fPqL+mMMFm9bCXdLXth?=
 =?us-ascii?Q?FsuneUw4BktcIKOdF/mbvV/Ll+ER44gf88cAWqCB9gI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f74aef-df48-44d1-fda0-08d8a0d0c9b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 08:09:47.0060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZVCsxM7u+dt3GLCgH8f3MC4OWkC/xpdMpq9vrhuQJczCQyq1JcHbNOLNyCCkChsOLukIN/qRtrF693TkEfKlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2208
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 15 December 2020 6:53 AM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: andriy.shevchenko@linux.intel.com; robh+dt@kernel.org; linux-
> kernel@vger.kernel.org; Eugeniy.Paltsev@synopsys.com;
> dmaengine@vger.kernel.org; vkoul@kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH v6 10/16] dt-binding: dma: dw-axi-dmac: Add
> support for Intel KeemBay AxiDMA
>=20
> On Fri, 11 Dec 2020 08:46:36 +0800, Sia Jee Heng wrote:
> > Add support for Intel KeemBay AxiDMA to the dw-axi-dmac Schemas
> DT
> > binding.
> >
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml |
> 5 +++++
> >  1 file changed, 5 insertions(+)
> >
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
[>>] Thanks. Will include your Reviewed-by tag in the next release.
