Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3701E6ACD75
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 20:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCFTDC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 14:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCFTC6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 14:02:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D8730D8;
        Mon,  6 Mar 2023 11:02:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fz2hEZcz4e40UiD7kGdxpzIVtFNjU/+YLcvar5hpxohMRxVFkXpaSpXRvuUjPW3IcLT/n+G+baN0AaHRdIrdFhsdmQ9fYvshcPNmM2z9yntSzCqRdzoV5blWJ1T51qkCZYLDpRuDYY3jVEF7act+ydyW/biJl970Yz2rE5A9LaCGJQBn/E6ze71P9w263ogtl4+TFkRVvW+gKHOJlDb5WKmrSs9lfQsayPDWJAQm1wlWL/Pp8L03nrCAnw/BvUoR62aq0uAG053Ex0V0+ZE1QKLMs/69zwu3PBP5jqVMnva5tWKUCVBc9MTTjNhWL/2nEcid8MlmRpCelLYskfGo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VwGSXCRYRMTRKGmmzb3tF/TdMHteW2ZJ6la1YPDHZs=;
 b=MeFbhhAZkkfCUkjVW9/kXDNnSaBcbjGcwyecmMI/01+oclilVWPkjadZe36sAHEkk9x5N8Q1Pf59JoAgTDT8MCWBnpniAiufvwNJgcYTjXb1OTgfiFEcWPsqa2rC/yUbOfvdd3OYglaz7gAkj/Q2xZc9ULJWEP4cMQwewtNjpg2pr4rzdU7n8WPUiuhEpXhH8dIompbvOwDXGYWEKKvF36sPC9kOlADKeVSqDQ9BpcyCdxv9ooAahKEeLGhX6YpAut0UU4+zkn+KHBDfHlItd4HDJWzfLFLgr9n47G4z54nYhJA78bxq4Nt5KTCFWpAeV/NSbppVG0WmQo5M5rkuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VwGSXCRYRMTRKGmmzb3tF/TdMHteW2ZJ6la1YPDHZs=;
 b=pl178hZU6yh6kS1rymE6zFA9z08kQbMAI/ftw6jmMktXr3tww2+N/g9+fSSgwezrpjyKGxMmeRzJyTQ9Q9uZdSeaLtVSRF0VYSR+q5KIhp5HSzav3XIFpJmJ2D47V+a1XU/rLeLviuDS9nFXh2vt98ATzwqft30OgsQpZl/6QysPLZgWH/fv5XHFA/9e1NzfAvnNH4f4I4wXVbFk0sMYHb7DQYjDaB8o7PWTvRDQkY3w5w3uJsw5iuHhNCvBJx6KaIQ9UqqWREhqm0puNEkCIhv6GkQjyCmmG5An59bTuj+v8btQGDKkwamQJBqHv2bDNhyNhRSlQvYNDygtGbT0yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 19:02:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 19:02:38 +0000
Date:   Mon, 6 Mar 2023 15:02:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <ZAY4zd4OlgSz+puZ@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
 <fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
 <BN9PR11MB52762957011E60E935E82CC88CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2c9115d0-f251-c284-63d6-73714edc96b4@linux.intel.com>
 <BN9PR11MB527634EA1ED5067D1FC0D7C68CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7f8983c8-b703-4960-67b5-97f4053329db@linux.intel.com>
 <BN9PR11MB5276E48AA1680C76A3ED66AD8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20230306110443.4ca52204@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306110443.4ca52204@jacob-builder>
X-ClientProxiedBy: BL0PR02CA0107.namprd02.prod.outlook.com
 (2603:10b6:208:51::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 431a9748-c23b-438d-ff76-08db1e755ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxYfk+SHEMryo0DL4VH7wfB7BnYiHE6Hz1KT23wIbnsAPy9vxbmsDtmzQKwSuU6eaiNMsK/UOMGSVdBD/cr65PFdNxH89ZDgAfvMQBjKWiSgIUuusvyfF6L/4o8xj8ZdhAielXNPvMXe6aMeqNbQ17P1q9U1yuq0KcL+ZKN8slLBfOilWqjN2etAv6v1/6cY/8Vy8P2bBoXn9J8oRTu/NkhgoqtTNATZm9oVrIjGxHgLYAObQEe/pXIuxeqqOAxYbWu0u9xy7vjM8KNfacpxqq1GY8bMB6PXhr8WVRrqcV11z7mxUifuC+94RYSIR61KLB5w3dHFQjudJXTWJPYjf3rXRAW9rwUycXN/IPolUZT6tKmgfxeZsp/ZLMPCPoDxTv1qOSo7zqpAB8OQR8nJAznxvMVvsiSrGWCgY2M5W8cGomy67tRJqQv1Jg5webndG0sVmLyC4PzXnDGv+kpOCqBEPmzrE9l28mkFFfP2cIpCC+P9p6LkvV2FEHe1Xfr9BRVpVU2m2wogprDSAdJRN2SN6mML/umXM4UgXvN3WfLYG0JAUSJQkYm1rO8q26UsIKuhSNakLVfG9km0xcDCwpuZM8B84pq4opJ7V/U5kXvqieP1+e2MP3VTjI1416CoygRN98S88AebzHOOkivWNHFRZtKx9D+ZmeUBGsXegoqpVCKs5fn+Snzxg+casWZQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199018)(54906003)(316002)(6506007)(6512007)(26005)(2616005)(36756003)(83380400001)(186003)(41300700001)(2906002)(66476007)(66556008)(66946007)(86362001)(478600001)(5660300002)(7416002)(4744005)(6916009)(4326008)(8936002)(8676002)(6486002)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LnmYawWr+ZhCGVL9RAiJKXwn0d9AurRF4kpmWRt3OZClMlsoIA7N1XhComQU?=
 =?us-ascii?Q?ArA9WoT603uligjQCM9A51q6k+yFcuJEZJjzoOhGkGR5cAL7FcbJmnLrLqEl?=
 =?us-ascii?Q?+glqLeNPBhr+G/nMFqWN7P0Ld9k8kfD1MFmKlLpAJeIjTkcKlwvyfXY1sxcd?=
 =?us-ascii?Q?+Z3x5pE0XucbR5zIsPKLBx/q/l6AwpRDIAXzbYHolpYOAY159qorETwN9UzD?=
 =?us-ascii?Q?D+U3izr4kFDJFGpJvuoXAtsrNe8Kp9cgPrXYnLojxKIxr2f8Wzc3SBLD6nxp?=
 =?us-ascii?Q?gSsnjWcrpwbF4yMSQyjSyFHVPRDa8GmUbDLyIlkAFUXmEN8D/9ZFT0zG8pNg?=
 =?us-ascii?Q?Ze/+D+fCXulO/XT7U8kEuvPaZo6xSr9t2gVIQtaKKO6+ZWXGImMzvYPHvMAL?=
 =?us-ascii?Q?JxdVvxaM5ITkFVNvVMsIFjrPkfh7F9F93vIxkREc0WKOHkGR4dp5OZEZulNg?=
 =?us-ascii?Q?xletFP0aFZqNhqCZdqCW5BlAjcz3KSXlYRAeED5AlxVjvHrol5Aryttyg5Fd?=
 =?us-ascii?Q?AxU1Hwo4hrupx0mLwoqVaxbVfsvsvQ+BmmNhMRJVZvo1bQg/6EecG/fTHJOZ?=
 =?us-ascii?Q?7IPtNqCp4LgrH0OgPz7js8y+xqF99RIOx092qnl9511HXkhACXTa/sx7IDNP?=
 =?us-ascii?Q?NWXFUCZobtf0Lb/rKvQDH2IQu443QCe9eLgnIaFMYf4nppGDpEsWnjhRDCRa?=
 =?us-ascii?Q?+vhx921DJZTICKrIlbdamIJ03AU9Vq3/LyyQ5zJilNHc6aFQ05fHAITiQYmu?=
 =?us-ascii?Q?9wCs04iujnvhTxWOUdR/g5oVWNIjC6jlA9HqmZVrWbZDJQI5rH1DLybZmUlJ?=
 =?us-ascii?Q?Ue48/thyWv1WP0i/c/1vMmHThWR8BZXY5bQlaO92Wpl2InGW0FaqSdjJiOka?=
 =?us-ascii?Q?zN2de0fEGLfpPPXN59yta7gmyaIfZ/hVgtg9D1AhB0MVdaf/gycm5cIxJp9Z?=
 =?us-ascii?Q?+RCur0vP0R+7KvjSaUIFy/55Ld/H48vZyzLELRA0iAw+JnGDNvkU3LfkhDaX?=
 =?us-ascii?Q?1D8cX3S4OT71zWLZfiaxlM5+k5xyLaT2TSZbKmbPvTJq2ogZGxsv2ZhIAtvp?=
 =?us-ascii?Q?xEeYJpfO6/GMdl4/q2w+JkOw2dfCDOgv8Dc1pWj3vTUYARvMaJb5oZX6Rm6B?=
 =?us-ascii?Q?UKtNw3PRtNI9gl7s9SBgpEBCx3UysJBvkTQK9bbGB5TMtH7DIr/d+1u2XzAq?=
 =?us-ascii?Q?ub9wuqhS4mFIT0wFPr7vRL18/jklYHrVF978+XwkcilHVnRQe76huL/crovN?=
 =?us-ascii?Q?ECfOwgsF6dEiZDHLugLnK1bRfGyKOA1m8fi+4rg7zbwfUnxWiZ397C0V7eWy?=
 =?us-ascii?Q?ITqklZqTUFq2W+x4BFMlLqsuCe5vypLIosZ58oIZkjPRJSUjb+mvX6fCmCOx?=
 =?us-ascii?Q?RX+QDWX8+8tM+9lbtfYpO2p0yyRvvwQAKTBEA7tmIl0VZXUXbHGm/XNH5NVr?=
 =?us-ascii?Q?IWgBSIJOeWL4XISaN4Hx4pW49DfqyuSKtF9842puZlslVqVcpT1P1LO/NC+h?=
 =?us-ascii?Q?UfInK8Sczry0C7OtPnxkmov1as7VDetes/iiN3mK3i7fszD7AhhEIkpHos9G?=
 =?us-ascii?Q?9kVzYciP1/wMooY7UNnuuUlGL1p9NstUAHA+Ve82?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431a9748-c23b-438d-ff76-08db1e755ac9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 19:02:38.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brGa1lmyANxQY/YuEMQXiG5/SjLcVE2h4zxkf6t8OaGslwTaT82mhAn4GR1LOL9S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 06, 2023 at 11:04:43AM -0800, Jacob Pan wrote:

> > and probably this is the right thing to do as in the end DMA type will
> > be removed with Jason's cleanup
>
> so, let me recap. set_dev_pasid() should make no assumptions of
> ordering, i.e. it is equal to iommu_domain_ops.attach_dev().

Absolutely yes.

You should factor out all the "prepare the domain to be used" code and
call it in both places.

Jason
