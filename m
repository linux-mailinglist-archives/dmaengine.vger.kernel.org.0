Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE25719FBE
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjFAOWN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjFAOWA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:22:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E611BB;
        Thu,  1 Jun 2023 07:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaJGhdVXJPBfPz2NhJ1CA01l85iU8o5zIepyuIbNdd0M9rhcVIsQSVO8xWa2nH2uSVhjK668mEZEcbNMza8/JDx0dIWDHfFt/0zSmCqmvFVR83t6SQvP33SQLAVzrfXauc/UtFd1bkyg5gVW1ZIEYHt8oOFINBXOoHsaLhz+0KFXC+6PTPYJC8FgOi4hWzST3tSUuTc/3WjP5utmwDBbXmyw9ip9hldxCEhOKbu4/XsesNF68c2r+ZI7iTttqKJ62L5OFDp+ycTyKbRsCYCBM99rPvBgoyxk6iRHr0r5wKEyyVciBDmMgFRSjjZZrY0CnqyR+NpfGEnl5zc0/YjrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsPfpPbCukFF1WJaf95QnUvNfEQ6DU6+krbi9Dg+5ZA=;
 b=U+68nFlLBRRzyF+ngmRzLqjvwaqs+7ROm2swyh4EyHrEG6wtI/0EG7TNLq6/dAHVUwz8z9peHpXx8PIyb1GnHOCBlTj0EJ8U2PKPUvZYAAygKasFYWLBWZ8Mdu9Abg84dl0qPNX5dTVEXqfSOSn3lTNiWC4Lu8zbI5NLrB6ApgylKQjuvZjxELVg41sVm0KZOBhdsT/PyDLgM+znYf74GYI5vsMzxNF3LpDi11x8PMa1C+yP8ia0QLU6BKaZkHipczeQWRyvs1JHYU1OJ6derzRxLaU8MGX1TK9U8HaJj0B3yge+H8U/D93MjR7ue4dZkwTofhHmEvp1/a4vjYCT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsPfpPbCukFF1WJaf95QnUvNfEQ6DU6+krbi9Dg+5ZA=;
 b=HX9dDqW23YYsWJLIbit/atNTIBBjH9JjWpnO7YBpzehSUscOjSi+TZuYMWfYjUcaHUh5NPHd9zT0TcJ3Bf9tkwqY7vPph85Z1vuqU+zTe06zSL8tfxOCED2V2TrcD0htdog/92XVrMH8HN3Sy37xJXoiMgMLfZyBDCxFH/7mx2EEFlJKfwwj+Xhgf9jp4YtWqZb/QsOwNWwPGzD3w1vaeUqPiw31/k8qSdeXEmtv2gj8cpfqGhLujMxIE/WeJQe4t+5Tx/iv+zx8e81WVU3xgp21RG8+7gIXMjHQ9eW/TipOhfjmh2LAhSk6f5Qnc5sCDMFLOpE5COsjBS6vGkxzyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:21:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:21:56 +0000
Date:   Thu, 1 Jun 2023 11:21:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com
Subject: Re: [PATCH v7 0/4] Re-enable IDXD kernel workqueue under DMA API
Message-ID: <ZHipgzmZ9q3Ihvk5@nvidia.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230531213342.1a3f1508@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531213342.1a3f1508@jacob-builder>
X-ClientProxiedBy: YT4PR01CA0167.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 81434a72-7dbd-46b6-1c4c-08db62ab8e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sGBa1Yk0hYSY44IXzZpeQBMxjs5bxEncye4/qpSN5YsvfO2vMmbpltE8wx3AOgz727dYkt03PPAfDsE2jDxBzomHQcJavlBAxqFzIgkN45cFbM1Rji8CR7Z5A+O7I7U+bIt2tmxBhhg4D6aLoFzBeoco/JRr/PSx5zmX5mXyq6dYZcJfBzbi8S/PF9lTqaq85cgxS8Ew07utE/StYQ2RbwIZzkscH6+cvOrjKs2vxX22XJ0bO9X+k6TSZ4g63p2G2Jw9sMyYrHs5Hn4Y2SgwkhcJnZQ09U9SZJer0CBLZKB1EW77XqKBZBXY9QZfnY3fYg7RpiealkrNNGKzuNOfW+FfbdmDVSffwRsvML0vv9j2aPq0+DV2+ujBaye1+BKrbm09SSBLLFsagoKkq8rQi33DhLtcVc3jqnoBuIIACJTQJpYW3xT8Hb8LuCye0mcrBajxec+LU6hnFYWpdlhgFoDjwnVjvWZkUUXViKbmsBAt534Xkcjbbjn570j5nSjpeX8cOHvO68DRFXjRjHooVqCwjjksPOd7DiDr0MPAXJ4+Pi/JKwsvaRgdWCNrgQA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(6486002)(478600001)(558084003)(83380400001)(36756003)(186003)(26005)(2616005)(6506007)(38100700002)(86362001)(6512007)(4326008)(6916009)(316002)(66556008)(66946007)(66476007)(41300700001)(2906002)(7416002)(5660300002)(8936002)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q1Y80z7kjvRws8E+yAftGCPvcet/nYRSSNQ2PtHeTj2UEDEbxNUfHosRVRIt?=
 =?us-ascii?Q?/jeAEwzYvSETMJYI3sppj60PvveetyQIqNteApBiM0r69StVTN/ph9G/GNV/?=
 =?us-ascii?Q?ENQcDgLfRltMp6w48OJ3/ePXS2ns5mJ7BZKbxACrGzuFxd0An3w3K6BSs8iq?=
 =?us-ascii?Q?CnyZDJ/xEr5+eG7fJ8nK/yARyonv08ZISJe+VBjkkIrMbybgCW1X8FDzNoGQ?=
 =?us-ascii?Q?UIcYedGGglk6NGLesZk9PVEMp/SbDdN3XPOLg3USCFyaIVLYibgpohNMry1a?=
 =?us-ascii?Q?b6DnPI/+O5R2XnTec9e0mPQfP+JFny9TZhhC9fIAskv6a2FZ5UXGc+74Mjmy?=
 =?us-ascii?Q?K8nJ6k+1vTW422fFiQexcSSCqnynC6+8eFCKofZfqoVGw+l22svzeePKcl9f?=
 =?us-ascii?Q?jU/6E3fktUbwgGzrX+qLDzPrSCtjHhO/5WLeECHOKxwLk4JsGPPkQDwbC3WV?=
 =?us-ascii?Q?ORbW9I5+/2GmesnInm/ZqriYDbIdcQXrjlFDujj876Pf+C6a84JXnZUcPMg5?=
 =?us-ascii?Q?aKH3lTyfaVQN1P+w1daR5sfI6978RK/VYMBagPCzQkqDiEqvwUTzZv9bKCRl?=
 =?us-ascii?Q?TR7dHRKc8AeDE1zidgh6Uramp3atBgreDmwnfAnLuI2qFck3I1zHwZXA6Rc+?=
 =?us-ascii?Q?Z9WkO9Iu5FDlsSwdDnCkZeDEofjo/1PQKQyJeQyoDYbIx7TGlDis3acssu73?=
 =?us-ascii?Q?LknNSbomEgUd3a1Dte2BqdjcqvyahWl+UB9yEd9gXiMlSRuIJ3cLWD6gvE0t?=
 =?us-ascii?Q?xl++PYxuZXQk/0Y8iGhgAP8ntpQ4XmpPhrg28UdCz6TXuiFAGfHTh/EF/K8n?=
 =?us-ascii?Q?1nOF36f8Lf2VlvFkSG+nZXR4B735CcDKuA2w3sr8r0A9lnjMZicIoPB5xKYI?=
 =?us-ascii?Q?ZMIrYJJJv7qjFb3UJxgiqeRnrx4MfcB8Zzn+4Lqa6OtFUo3dqcJdCofl+8Nl?=
 =?us-ascii?Q?M5gUCK1ApsuTA2VGHsEAgSlQzzOI/GNDuyPAZ4RmGz8zL07gv1DAMTnqYSYf?=
 =?us-ascii?Q?YpHjQyUABvC072OjjpE6Fl9KvqGE1EfqwkoQ3UBhA3ORl+c3XZapGHa0D+Zx?=
 =?us-ascii?Q?VoDr60CEO8RKJ+B0il0KsNJsHgF4s1QqeCqfrnXXIDi+tcJRggcDAcYjtl3K?=
 =?us-ascii?Q?3sGQ1vEkUZ0DjeTQINm8mMNXOVC6qPoBIaFT+u2I8qJPo5ff6ewfoocKuIKG?=
 =?us-ascii?Q?BoP3d304PwaNZ1QhaYEC1DdecYuKQUUTkn04u8PYV/Ay9uPPCt0N5LGGJiO6?=
 =?us-ascii?Q?/ZKJiBYp705/YE0gK1C0lm0lbHQNOvWB9tJvLStiO1+qKls0JxkvmraFKBDM?=
 =?us-ascii?Q?YaenGX+57r1Bxl4GWGt/i25DjujCQhhz3pdsbEEpVJXSnP3YpnNBWJHO/QFa?=
 =?us-ascii?Q?hzPtbcQiF33OLXCDYSTHKjc/5Gn7+KIeAyGPmAPDM8PqH+VpRbGBpB7Hp0d/?=
 =?us-ascii?Q?f7ABus/t6s3iEWTnAJjPZi+Lmwf4eK3JhN+Aq0ZaySjDeUmYehLtvigxDR9V?=
 =?us-ascii?Q?yeyiNDRijzwXd8eVq+7ENtFPciwor2ZoVotodt7nWVFq4FCEw17DLLDuac5X?=
 =?us-ascii?Q?a1WL0TfrCyAgdEw7eREegHVzx+L+1wgsmaxdFfL2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81434a72-7dbd-46b6-1c4c-08db62ab8e28
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:21:56.8501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFB06rqu26ER7ZXDB3FFtdHIWiJsjw4VQo+NilWA2/Z+CcW3TAMGZU3pYlGRU3Hd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 31, 2023 at 09:33:42PM -0700, Jacob Pan wrote:
> Hi Jason,
> 
> Do you have any comments on this set? this is a follow-up of the IOASID
> removal series.

It looks OK in general, I see it still needs another spin before the
driver part is OK?

Jason
