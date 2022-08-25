Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EC05A0752
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 04:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiHYCi6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 22:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHYCi4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 22:38:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFE2785B4;
        Wed, 24 Aug 2022 19:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661395135; x=1692931135;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=0J6dwNNbm3Cv7DBzyDSiGPuGIve8JhcP4iMOZ3F4JeE=;
  b=HqIV4nKXwesrt9yoyyQoJm8CazspExQCrIrTQA3sS94pVZ9F0j/vseGL
   1+WLViaHo2Dt/gn4Us1DmOdYM0JfRNwVmd0ql4zZKoOdCO19vViue4rbQ
   8+uFGOTQEGtqH/a/BEoysy4ogz+6iTWqoZ6m0S4rA7K3DF7XcTBwiZXeE
   2DNp4gpaAFi3OQ+/MNN99YtObvidR/h/efsYdMKf55wq5VEvibzA61gxp
   hF9ZWJaudpp9D/4rov1AYV26J0NZUc4FqVAWVVtF8RhFhlHlCD/Zknerx
   EvwkSccavOY3Ar5WiUWY6QRIB68BnQ+NSRqgy6IWHacXlJmBa+YipHy1S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="277149419"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="277149419"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 19:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="855480275"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 24 Aug 2022 19:38:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 19:38:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 19:38:54 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 19:38:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyDSIXA/+tN1H6ltJrgaMMQKzov6+Olqs5sNe1IJDtByJGUC/A49mmFRY/InqwcEv8hBAVgTeaNEl/jepPC6Z+cBcsdvE97Afvpy3VSA6U7f+IXwb6FNvi6SFwYOT3o+O2/YeKynvikvgyo7pecjHEPgr2n4QuRNR3GkskRfHCOS9e8IVlczgU7hjqubQvXomSgozIAaBR7aWOAmwD2AEF0t4H2U3wKMB6KpqFnsF9zDvGCOdScHcSpxTr6eG5mex8sqPCrOG4oKTA6IrmTY2eP3vmiiD3Bw7lGqqNMlpeqEf1P+cBlo0e8b5q6OowgIusjbYA4W2wX7GNT7nS7TPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0J6dwNNbm3Cv7DBzyDSiGPuGIve8JhcP4iMOZ3F4JeE=;
 b=IuZDB0B5reOIWVCHxbeFliDFgY0aOV3EOBSBoNuifVXHUJKoIH8JLD6gC3JMcCWRCAmSBPq7XC6F4eWX/rCQm+lJJg+uCdgnXiV6Z9mSOXYwOXA5lzuOo5QhXzS5OL1A2xBG8Y10Xfv9T5N6y9Y3AbyEGoEhmgcBgyIg0kxzd9qudKjuAEVVJ5DHvi75jShpnd3BY/UJYknMewRjCYGAyItvEm9N1Xy4cLGUogWiir7l7OxEDQCPxXg9uXEz4EmIyQ2PXuot4UC4AFcfwqcrkEwsZdkEmY/bEvTL0zwWhIGoRKH2DMt3SMtr+VgJxkPVDgS3uNdm9JW0ooiD53kxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3674.namprd11.prod.outlook.com (2603:10b6:5:13d::11)
 by SN6PR11MB3485.namprd11.prod.outlook.com (2603:10b6:805:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 25 Aug
 2022 02:38:52 +0000
Received: from DM6PR11MB3674.namprd11.prod.outlook.com
 ([fe80::fcf7:6d70:f7e6:cf42]) by DM6PR11MB3674.namprd11.prod.outlook.com
 ([fe80::fcf7:6d70:f7e6:cf42%4]) with mapi id 15.20.5546.023; Thu, 25 Aug 2022
 02:38:52 +0000
From:   "Zhang, Li4" <li4.zhang@intel.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Zhang, Li4" <li4.zhang@intel.com>
Subject: Recall: [PATCH v3 0/2] Add additional IAA (IAX) definitions
Thread-Topic: [PATCH v3 0/2] Add additional IAA (IAX) definitions
Thread-Index: AQHYuCvQWWZ+ecESKUCy0g315P0iRA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date:   Thu, 25 Aug 2022 02:38:52 +0000
Message-ID: <DM6PR11MB367411C4AD2BAE47E9DC82DAAA729@DM6PR11MB3674.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87c27864-b459-4453-457a-08da8642f2c4
x-ms-traffictypediagnostic: SN6PR11MB3485:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r4OgOuel+Cx/4ymr1SJdYdRM1zsusnAz50FHscaKXwAQLpjsVuGD3JFnqkUJKWIo3XqB0fEZEUQZmm68/Avm080zKceYqB6HxfITPbbYT7Zy2vJwRmIBuhr0u+s4YZuGufcwDqNCvgKa6oro2pjaASBeIBZPkjwKZyhdjzz39ws0QawToBaRX7J0Zux+GgqNY2ICLUW6K/0ljRBdV6piZHyHMFkmlEQOjGL4ZR3KtipljEGsbfKWYeZq46Tj4lyMvPWeGOpI4UMyQsPESF46xkUseO0gf2yA/6prw9LopXNawC6RxYM2tc1rwS4ufLbPD8Y1FrAQIIhgbNtQGKxgDRTLvypDDUS0OA3U3pUzZUzns6AsAqFUhtSG6o5xzp+71L6/xCZJuUlqQ0/pTe6VNRKDDuLaAOt40eVQG/PEnOqcjja3DHL5LjxcUbhOZ2YU6AJSyQDIrDT1d2WHb/tTkUJ0H7LyJtbjjmnV9l//s5hnz/U7G/sWs2ZXK3vWnSEAQciH3FDUVeNtULozAQp8In7rODOd5cVnr1Sq2s5XnlNNIonifq4OAHard6c7jD4X3WVkrY2rjnOtCJSOVjB6IjObOXui5pwzscP5mSNiT8CdIyJ6ZdtyzX6ICgf53/lRdjmyBr8CysSraTUPXL0zyNGAJuSd+P/xxB4HOj4+xURtVC8SwbTg6K4NfjhURAtFVtQgdlb5jGbLo2bdgv77k69iecS8UDTowabBWlzhmKiV/BM6/0/lOOZHD7feicjOOEZMWVCaCdJ4h8N/v97RnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(366004)(136003)(396003)(346002)(66446008)(66946007)(122000001)(66476007)(8676002)(64756008)(38100700002)(4326008)(38070700005)(76116006)(86362001)(52536014)(5660300002)(8936002)(66556008)(82960400001)(41300700001)(7696005)(2906002)(6506007)(107886003)(9686003)(55016003)(26005)(71200400001)(316002)(83380400001)(186003)(54906003)(558084003)(33656002)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QtzhianwcfamHl7orSI2UNKbvUWlm/8zad/me3Z9lHlvODmUMxu4UujnnnhA?=
 =?us-ascii?Q?/L7GoZSMyVwDkTzgqSToozFLJn6GVB0xyvFdEb/UXzZCCDB74P4IpLgU3ms0?=
 =?us-ascii?Q?ZI9tnfxQglIZuZSdYps2pboRFEy7XsiDJODgXATXNa0gEgtZhPejm+Wycshn?=
 =?us-ascii?Q?iiYRwKggci94wezEP4NArJcn5e+oP1IuWGBoUfRAqK6JmWVERvmNtDc9z6Ky?=
 =?us-ascii?Q?olH6kcJhcQynzIin9YNapayeik0KEeSbGGQQbci+EWPHkkhqJORidFQHe2H6?=
 =?us-ascii?Q?PpAMiM2bHF4a8ckrDCSJO3Q7FPqVmqx/aqn7y73+XS1wR4cNcXB54jhiRojd?=
 =?us-ascii?Q?bryrOAPg5hvBRkxQZxLMSHr5vvUKgOQxEXW00Qg6rF2/trpM2SzL4p2J8nFM?=
 =?us-ascii?Q?Y6DOg0M4yIe6bLbIg006hJEElQ9VYBUCc/Q5cTvso5M/7qy/lh5BkNRz9SON?=
 =?us-ascii?Q?MIUNNahwUqplLCf84bJqfl23BOBVCfRSVrs5cVx9PeEheROYrnKPEurBIZMd?=
 =?us-ascii?Q?fb9zY8CTUTybIez7NCwp5WCNCP2x1YLHcuVqDJffP0h+j9ClYAl7PxRlaqb2?=
 =?us-ascii?Q?WkDdmUpqFqAJOpdsX5luFR/jTdKKaSyqDY4/cD3ILe1bGEFU/UW86c0u9apH?=
 =?us-ascii?Q?Sea5TNl9QgUztJdP3llERMRpkyWwcWONxzciKBGYlL7VE/XN+Ie2Xq7nIr65?=
 =?us-ascii?Q?DBZFEnmyux0AtrCHGIU/nJfr0Iyz3UqJ+T+Ef3IbAvVVBjgU4UhQB/DgSCSH?=
 =?us-ascii?Q?qagp3gwf1t3eSTU157A29Jtuj1NGOYbXiUUNZRVVXWEMdRYUu9EiYwZkXpOd?=
 =?us-ascii?Q?LOnHvkWEuEdEAPSzKz1WqY50r8ggXo2UHBgPRHzk10rafg7JHZuYLPKBOSUz?=
 =?us-ascii?Q?Ym7EuQ+M1WIBh7jdSyLMUzVO0cs7JcMWHBSQKT772APeOTOxS5RDM5YL3a4P?=
 =?us-ascii?Q?T50hq61ZnUAE4WS4Spjf5QnAwQOoP3JQIrIdDAWlnDlHvtUZC57zhVX7Gb7/?=
 =?us-ascii?Q?onxphV7n8sN6XRUmXszdmuag7MrmgwI4htJjKGdDLzpb/r/oz1KJNiTQ9sQb?=
 =?us-ascii?Q?xOtY72qV4CYdEyWgvWWHiqWx0kmJZg1gsMPQ8oW3R2FR2W22rcm+KGrfvDN9?=
 =?us-ascii?Q?Oj/yDFo70foH/IcIgxcXwsRMGrPxqOPdD4TBBAp4rfS+g/ioYsalTNitbWwC?=
 =?us-ascii?Q?6mHvBrbskhiDOwSLYefSBejIfioZ0jq4xM66v5+WKSLZEeADaLzs0rpYwZqr?=
 =?us-ascii?Q?gbXF+dFt0wltunD9KsAbYp10Nhrp/GJWTA+FklJQjcoce3SwQL/4a7KO1GaF?=
 =?us-ascii?Q?u7eALvIqJguAXEgI1oHYGEr3neAhsqRsBmTaQ8sVpCk3pDcmnFBsIzDP/aEn?=
 =?us-ascii?Q?whqbGDowWJSd2PesAxlQLWHDuzZPx7TN0xWPjdMUzbzCsiAeZRWprmRxGafh?=
 =?us-ascii?Q?l8AQEwprV5HbiVE3wNcK3X92ZTqNpJpNqHX18c6PyLHsLkkP4Axs1HQNbrag?=
 =?us-ascii?Q?yRL/VdmC3JG1nkTYEJyrqIUC+AOw56xGrrJmfY/tO6zJSFkxykyFJcl4oLqi?=
 =?us-ascii?Q?IXY3OidpVsy9F9lAI2Ud7bIOq6xnUUts+si2XPv4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c27864-b459-4453-457a-08da8642f2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 02:38:52.4634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsjhCCJRBtnWOKOLl3MrfUqKWCQUFAMr3+xb0QGe57Dh69TZy42b/kjl2vNk6oOMEH7TVPs0fBCGN8Nyucvvgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3485
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Zhang, Li4 would like to recall the message, "[PATCH v3 0/2] Add additional=
 IAA (IAX) definitions".=
