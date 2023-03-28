Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EDC6CB3A0
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 04:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjC1COt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Mar 2023 22:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1COs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Mar 2023 22:14:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9A1170B;
        Mon, 27 Mar 2023 19:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679969687; x=1711505687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EpuonLJus472H7KxTP+fJNDh54GGZ6sPI9n8spJuzPk=;
  b=L6ogP5aqG1rfc3e5M0O3JPzVyXIjxjtqlZ2eF3QlpOsi1l/sz7VIi4SY
   p86YEZkDGkAO+qHlYZ3Tto+309Hx1mig2Lx/dPB5F07Ass92ITvIoHpVb
   OB/q5x7lz57rQow1RrBb8ZkrzQskw7YFDejsg+8e4Bx5GsO61196UorPZ
   +vElDvktfmCSNp/bsLKj92WNp1eLGhcpnFagZHuzrOuCsije7WTLtFfzF
   JyFjLk7tyzl2vPhTs736EqVmPR6VdCPFG+dV62ig2oaO2VhmV2Cu4f0z3
   ZutVBYf2mTeerTP7Clm7cNXUnB9MOzTOIRNtVQrFW8ztB2uwGO/B/4iAW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="403055341"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="403055341"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 19:10:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827279898"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="827279898"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2023 19:10:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:10:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 19:10:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 19:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLiT2WWzxe55PUDZiC/lZLWqGJCFjRv8Pe1+dvPY8goBzbMzl/GqhVm3RO7w+4Z/1OZwiSwgoBzjPIKpY7UimfcklUyBgaqKBXrfcDRGFKeJKfM94/a3Omw5Y/HELBAtgKWTtGJQ3QP4wnxvi9l5nGkNcsgEvnZxQYnb7JElo30w+aT0RETIi9uNQleDFfYiKz4di/xq5J4N4XEazXc65LVoTRJlwQj7/F3BUvEs1k+1kjlkfY6D+QS8zNg3p6Uy3Cz7dtOdRULn9NoluXuq2lMqLN+4CV7giH4v25c2+VocKGvKomXxnoBVaMlHYvuCSCkUetUrLK7MIZcTixWlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpuonLJus472H7KxTP+fJNDh54GGZ6sPI9n8spJuzPk=;
 b=bnh1veQ+14QEARkJpEuTFSRZYN7CIAKfNRgs1VZK9hKravLYzc4RBH0nWaVShDuAwsbmiA99RQebiZ9FrWSr82wxepDcjoi9iSMObf0wGV/tfuSoy7ySeZWhfNtOyocSIo7XivXdcofSeu5y7/ATyiRfhvLiuIDt1fPygH80aEiOG0bwSxDTfi5BV9Ux+k/UXzjIggJN9OsYpdJkRfe5am5NrA1gNhufFD0hjHARWOYO4gkPxEwM+qVao524pXczVpmSNjUiLoSICPDKaUqA0uB9SVjPwK255ooBawqrSBt4Bv49EQRNu7xpA2j6L+f0LQMlUt8GAuyE5GBs7vbg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6355.namprd11.prod.outlook.com (2603:10b6:510:1fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Tue, 28 Mar
 2023 02:10:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6222.032; Tue, 28 Mar 2023
 02:10:50 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/6] iommu/vt-d: Allow SVA with device-specific IOPF
Thread-Topic: [PATCH v3 2/6] iommu/vt-d: Allow SVA with device-specific IOPF
Thread-Index: AQHZXkiEefsRd7HM6EGRMsgoY+CBt68PeGHg
Date:   Tue, 28 Mar 2023 02:10:49 +0000
Message-ID: <BN9PR11MB5276B284EDA91EDF4D74E5EC8C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230324120234.313643-1-baolu.lu@linux.intel.com>
 <20230324120234.313643-3-baolu.lu@linux.intel.com>
In-Reply-To: <20230324120234.313643-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6355:EE_
x-ms-office365-filtering-correlation-id: 6d24f3a9-dfea-4ed9-a9d7-08db2f31a6bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iw4p/Z5LUotVkTRJlIjVoY31loHoriP64eYlPTDnqjjMwSJnfe7BHR/YstN5+S4RA2EWjlPHVkpWw+vgAgfPMDwGmWWBZ1lYDa+zx+uzdHvvfV+mt4sBCtVp8sd1L6rz8PlO+uB+0/rtpLsiGiUClCCHLE7IcBq0IP/zQNIXvcfTGgg2zJoEYoIFEFT4qB/qRUhSBeCnfJzTYd3wiUP7pPMGnEWx8Wm7AoQ6nTgzXeTqzSpxpPTdKTLHscwrAMStHyPAZzudR5DLnbCKd1pSAbzPa0GhI2HWDm1frczN6dqoxIZQ0BsosXg/MosIsoHDXx2Djq6ozERCVRE54pyIpTOJyi/3r2U8zI0PNSCHpSXvoKE3J3iH/1naCEpo0XVMQc/FLB28v8o3usXFXlMD0zpGnk4LO3NqxGk2o+IR6VMkhUWxFeQGr6DNlUxFKVjX8xaMzMRKZ/8lMqX2oxAH1Sr9AmxO3XZyQ4WGJDCs9Og+qxp8Yij9RpvWF/C5JJpwYA6hrzGESfrhLo5RyXXBIk7ZebhT0ErQJ9Ssjtxtf57VSsar9j68I6/Xe7lwYVUUt9WLjHrhXMH2an9x4MzWIET3AB6laT9AkEkq9AlE9cW3WRV9kNPoL3ML/PphOeQi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(71200400001)(9686003)(55016003)(122000001)(7696005)(82960400001)(316002)(41300700001)(64756008)(66946007)(110136005)(52536014)(478600001)(54906003)(33656002)(83380400001)(4326008)(38070700005)(86362001)(6506007)(26005)(4744005)(5660300002)(66446008)(2906002)(76116006)(186003)(8936002)(66556008)(66476007)(38100700002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5FCg02sKlP7Wz77vMYBhz0wlHBRMBd6QTMkOFeTXHP/7YZb4eprTXSODTK0P?=
 =?us-ascii?Q?UvesQJNJHXiXoIwVzKBavqnetsQ1D21xJEmJfnh5DehI3XuBjozIHHMKCOK7?=
 =?us-ascii?Q?NoW9zXrC0jQEkFmbHDhutkQhv2fl1UueQIxmK1mRQj3lJUv/rDfqptEJCnKJ?=
 =?us-ascii?Q?LR8Z89Rnp8cibbzNcSxmWqldMXwHjG/qigfBFWIiD1VjdBUiXqlCFpmpYCLo?=
 =?us-ascii?Q?vRHXKXBTubKKnpn2Hp4K9JmvQ6EeqKwUiDfFyoBTSSH5D4iaeg2e2lvU5VWX?=
 =?us-ascii?Q?xQzZb3XWv1Vu8PhIvl4K0r6sR8kaHizITxNaEsNawkSFdGBx3zc58tlgTbFD?=
 =?us-ascii?Q?eXlZs7q2uI81ZOjW5+BB6hPgaQPWse73JTMcx9p6UjDr6TsejbDu396gdXF0?=
 =?us-ascii?Q?CoWYmn3lptU99hK1xnJ73aP3g4IgfyioOu1KmewIozI2yAirjgvbGzXfGSCm?=
 =?us-ascii?Q?IdB9UqUU7gGjbHm/hJ/+/nhZji6PQs/sA58LH4jgoJNEhLb0sSZWZjLaMRoQ?=
 =?us-ascii?Q?A0ycxrJOjc8mIaHr8GP3V994eM0nlgaEliUkSC5bUNooUNGHr6pIhN9unPe7?=
 =?us-ascii?Q?ToWSNSK0ZjEvjxxG1mt7eErKFsbsr9ezzqhi290pTyIlQ9vrorOXnqvrdMGa?=
 =?us-ascii?Q?I3Abz8kMM8UQFfs1z1d0aS7ZzE1beUs9nMP4Vbe4eXmvsj65OdSoLRlym9bI?=
 =?us-ascii?Q?kBhRDNL3te63HRbyayGK0iwYrPJO9oZuWIKockbSWnDm/g3FpPJuioeCMA8H?=
 =?us-ascii?Q?IFxNv2tdpilrM7/HuNUZvwTulq5LLvQNjEbDBwQXyQiSqWbkNFlhxLrM9Mv/?=
 =?us-ascii?Q?EQMZIcPiABJ/a5x/AuqxIYQ4Kj7RIAKvDwVKY55fspP4O3UHgblV3Pop+HOO?=
 =?us-ascii?Q?2C+KjxARdwex/eho96LBOgSXShM3h4TU187JtpXxuCUOnhc7FVT5NvR6bEFY?=
 =?us-ascii?Q?7sfsin1Lxm0v14Pc3EE1WLXV980MWLcXKekhhcSe39VgzDDWwHg8PFqJ3upR?=
 =?us-ascii?Q?HJo6tEXPzjdh58TSMmZ9iPXAZFOrWTe1T9BpxqnCsF3DdYWh/NqXtGtcbqZ+?=
 =?us-ascii?Q?bvpwoiNfMPYBrmhNYPG9iUBv3wRgII1XawbuFDCHFOcMlgEOGuQZCQiLg2a2?=
 =?us-ascii?Q?mhVIV7fNvsytmpV0ap6gOLlhkynahBv/sshgF/BEIbNVISDtnFzoIHJVmChh?=
 =?us-ascii?Q?4v9AAO3fTS4n2v4Emm1Anh0BYGuLi3ZVzXvwatvNG0QH1jezdRnXSm5ElWW+?=
 =?us-ascii?Q?7A/K8MP4OS3ZFTz9noxU8bcvUXbvjJxT571u+X0wMQ1grpAEW++eGfiZOB8T?=
 =?us-ascii?Q?6klGrO98F4BxxqcP3I7u1EXb7/N4IXw9+1aG2Om6ucva4u1rNv7/SDKrKC9V?=
 =?us-ascii?Q?U/C/zwT30Mr32+FQVMJT1D94hbx+nRiNww3/cMMPzR/gY74d1upZi0NYFn2r?=
 =?us-ascii?Q?+XJZN5BP5IoZyWl8cxAVHBSHNXL4+38XAhtmOaRhP1OmcVN6hIDJDf0TBNql?=
 =?us-ascii?Q?qH7MpUF2j/W6ehYEWE5BKBxGYGkpyo8EvmxVO6PLxAkSLst2ZjlzQnPQNitP?=
 =?us-ascii?Q?qX3qJAlyD5A8jKGaCXOjmjM+JMAfr6DbupZsiYM+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d24f3a9-dfea-4ed9-a9d7-08db2f31a6bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 02:10:50.0123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JIVNyk8nx0P9Rn09XaNIgekE0zO/MCe5aELq5cESieuoa4fQKhXfZ/XZs0+8I3ODdmB/kTzNG3layiNs+tBqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6355
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, March 24, 2023 8:03 PM
>=20
> Currently enabling SVA requires IOPF support from the IOMMU and device
> PCI PRI. However, some devices can handle IOPF by itself without ever
> sending PCI page requests nor advertising PRI capability.
>=20
> Allow SVA support with IOPF handled either by IOMMU (PCI PRI) or device
> driver (device-specific IOPF). As long as IOPF could be handled, SVA
> should continue to work.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
