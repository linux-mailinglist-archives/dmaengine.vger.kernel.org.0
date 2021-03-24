Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A107D347A08
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 14:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhCXN5L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 09:57:11 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:55264
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235788AbhCXN4o (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Mar 2021 09:56:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnFxd+0Vq6eAc5CRjToQKe6CfkpBzqB7BoxeLjgV1v6/dJxxB4AIOwen4Anj/ottVC5o1lcej2wzVxtyZ+QkO+GPoygCrnzLzAJP6P1gTluKzRmnc6TESWZqaYKP0tpuG+aJnGzidodJtAjpgd8D4KSSYF0eYIVjJ1ghIh9iyZ0SFEWyXBtfe/6Xv1+n9yVQ2GuF3vPcSKiNLQlc6DsZs5K9wRWQBYilVThebZBPZEEWudDVCa4kP+5PwwMObspypvbJi0AM+pjSX/ufxE0qDleigbIPhMAHhCR1Yxd3tBdR9lxhwHkclSoBOixM7p8naE+YDcpPeHBYSC0tuMGc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inH7krhHu6cipvpFX6bUVipBMFO98qSL9FAJXTODH9s=;
 b=hHQNX2Y7bf5JJA0cYkkmmZ4QIt2DA+kdC66OHwVpxZ4p8obD2gLNfW7kG1UWO9fXLHSfe298fEzMumHMnPUxLZP2nAVMeLtuaWFBjEvNsiispeiEUk2J30zkr1SZNtznNcImcd5EsLcVHuLbhjiJ0mURmlWedhYKqFUVRTLj/PP4po7ihBHbBYDPDGPOgyC0kqGy0Vr0Wl28b2129MkXJD3weW43uLcJcq0ggtfnq6DmwD7VsU+SeoXv9ZDXbnBosdQ8n34KWGUJ2fJTe6hV0gLfFavYip43UT62USS6erImUVbPnVeOxUVizuOJzw6zHkc+Cg2qZL7SaSE3dRyB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inH7krhHu6cipvpFX6bUVipBMFO98qSL9FAJXTODH9s=;
 b=FqlrKjU7NtzVJSeWS3Wg5J2nlPuwkqx1XpcV+fC2DVLcOq182UlDxPXzJt0OymmykHlQ841i86oXOLc0TpbNxLWKmSXmkHFD2Hq3q9Dpq5QCxgH3n4gjLUs3hkfMyeK1EhlRpvHn/pXKVXuXY1vI9oIFilI7exGi8YEuNQ96l8mXHBrGNbyngXVyfIC55rxl7+hmB1Kcsu2s0FrTp7TlPZ6uM5wPZWWbJleGDB0xecRE7qhbemH3NGvhHwHBvtNlh2iMGEc+vUHLe+4FPBXQF6bf+PJCujj7JOGHLfJp0s6OBqz9zCzOcxz9RDAfouEAkHn+MKrcNFe2VbMnc7G1OQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 13:56:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 13:56:42 +0000
Date:   Wed, 24 Mar 2021 10:56:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 0/8] idxd 'struct device' lifetime handling fixes
Message-ID: <20210324135640.GF2356281@nvidia.com>
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
 <YFnU2oqNavQEsmNZ@vkoul-mobl.Dlink>
 <20210323115600.GA2356281@nvidia.com>
 <3e68045f-8901-c81e-a1d8-506c591060bf@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e68045f-8901-c81e-a1d8-506c591060bf@intel.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: BL1PR13CA0283.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL1PR13CA0283.namprd13.prod.outlook.com (2603:10b6:208:2bc::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend Transport; Wed, 24 Mar 2021 13:56:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP400-0021Cj-8Q; Wed, 24 Mar 2021 10:56:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37ae9774-16a3-45a8-c2f6-08d8eecca78b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4299:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42995D4D281B354849B9D684C2639@DM6PR12MB4299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWX7+bkCnuvCG1xeCb8ztSxO/xFbOenPw+P9WNlVR4qOlY/ZeFlXQJW8+P31ec63R2QEcAxwYHSuhC+tDVeUqRCQn6WnFCLgx6HrzAwR/8WeKfmehqkdUNa9Oxu2M6OVUA8rfa/hMzVWBbFmm/7n7EJSrmBHXjiF4MnMZtRhxbUOTjx1kqN84wnyHcJ03jaVIK2saqM8Q+DJb3ybrGRkQyZp/jhs9+xsNmeZOfQXay1rq9BVxWLfW1yEOqwBACCSdWfBVkiYXynNawf2ZRt9/0Xq9AI8IQ5JLEV8/fHKnAAK55WIcqBCJaA+GvfnbX2G5FUBuQ7QoZ0zYSxV+016qOZr7xLKAqc8T42nVTusMHj7MIi2oGq5Zy4BetsO6/CbVp1CoeyI/gI/symHDc3LSlxviLVehr3vWGxUPSrMob5bH1mCaQpMQ8HHrOyw5ZkF7x5ySZrRWrse5iKH8plmn6ooOJxJQeyL2w2IjFxrkgxsJrqgUBO/IcfTZ25obW1pXi0XqsPOEb2mXPBFrZnNO+hlsPajA44LdrohhWB5PQVRybvaKQwz3wVF2z3pAeMsbsdJGNPqgCdchEvRzq5WFthWk8j98T1DNFs6gID9m/rUZA9zT96+K4I7FXIFmEOuLQ2VIQp3t+LAzRUBjfFJLZBoogbqpFB4vtfyUs5V2Es=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(54906003)(86362001)(4326008)(83380400001)(66946007)(316002)(426003)(26005)(66476007)(186003)(478600001)(66556008)(2616005)(2906002)(4744005)(38100700001)(9746002)(5660300002)(1076003)(9786002)(36756003)(33656002)(8676002)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?26LMJVlOmYJ9CrHAmEoNEbCKM2psSwNzF+nr8dXmdz8V6uUy0QqHz4vCpgQX?=
 =?us-ascii?Q?VKluH+2lu1etKmu1APmn/Oa3UTeRJiyurC/SttqfkVeG+wkvcgiVBUjmxNNu?=
 =?us-ascii?Q?hPGYG/sISORPwtwUcEhdVwk7lYd2sQvSDN2rbrCSE2k5tS9yimZrTwg3s9jm?=
 =?us-ascii?Q?zweWR03fO8Y2ZNMDjHn9PpWb/srv4mSHIQbhDFHXX2f7T8xta8iJ+l1fQgAx?=
 =?us-ascii?Q?dYaCbE6n/LzqUSp9msh1FUaGLJJPgirWIC8IIpMl+2DeCLExaBq7bH8M8suj?=
 =?us-ascii?Q?mNMtfPoneeTIG3FOLXQo8gkEIV7U35nV2jlJ5GbSw4q1cKUVIwHb+QyWFDYn?=
 =?us-ascii?Q?1SjRqnPhkOjPx5hp26sXj04h4MsewNAVkRa59UXd9Xkm06M3cR5A+KEyxzy/?=
 =?us-ascii?Q?htvPN8NB5UfF8Dc8aztq5mPLl9ten28cc9oTgtDNBvpSaV+UYjDKdYDylegr?=
 =?us-ascii?Q?BwYkLMzTbcWFuj88GkQ1eGKdiWhBZn2KgkedbWYg9abt5owRPBvZF9fl0Iex?=
 =?us-ascii?Q?fd0cavRoIEulLVY8Oh1Me0h01jJz/kp1jZKWX5NZZxuRnDXMWQz9d80XU4UB?=
 =?us-ascii?Q?c+GWADUDwL27D3ec82TCWb8VdqJww9Eo5N1GOYGa1qQ2WpuZzBiwk+km2KvP?=
 =?us-ascii?Q?iMhbSgBwo88xYhhYF7PoNFOnk5awkH91h1M+pOk+7pbnP5lragL3EoSLCenO?=
 =?us-ascii?Q?nxUsRF59HadqFEoTOK+zIf7a0Y8ksOOUVRwjqv+Bt+6h6EGdZexYrqkvxzGj?=
 =?us-ascii?Q?O4ZTnDqAX18Q48jwtEsp55IRWdXlr7+6+KU5mZGItOsNWNOl3mYana4GfMQU?=
 =?us-ascii?Q?AYwD7pnbEjpjpUw2kwXWrNqJvKwZqEFNviX0DB7qnC9eqGWmVpnnd4VicCnt?=
 =?us-ascii?Q?+diBNEJG97mwCoqKvNtR0WxzDxi0FTOj760obX8qSUMia+EN22x6zwQY86S5?=
 =?us-ascii?Q?o/cDY93Z+sLRuENarFebQoJIJkNefZ598HJvuSGopW+wn60Os7o5IR2exwtW?=
 =?us-ascii?Q?/wf506isuU+hdi6Xpxf6mxJsmedpriUvOS/hPAEvqjAieH2Mc5UF7tHUJupg?=
 =?us-ascii?Q?K4fHX2i22xc7TIp1snfERFyolJezTnf+Gkyp3I7DZ7dF6UltalzcCxn+819w?=
 =?us-ascii?Q?3N/bfub1fcpHH+zsX77NRG+wzmDmeUN4bJ0hU/iGPd2jKxk363azHdc+KnmA?=
 =?us-ascii?Q?IqP1XTmgXuWGEUi8hMJyEcwcbOYBpvB9g4ZD2H/dcwV2b+vbUncr1HQs0ogB?=
 =?us-ascii?Q?+LLi7zzsNXrXPsZWJyYVKHEzJYB8sE3MxwKLGrqD4jMJj8h49eEgZ3JPV9sY?=
 =?us-ascii?Q?N9o+m4rPSTMALiTiAPdK2X9D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ae9774-16a3-45a8-c2f6-08d8eecca78b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 13:56:42.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwezXp4fmeQLbFdeOwzvdEwuoaYPpgSS3Ss6zBhpR5VQhIU6aP6snDLsqibiD9Kt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 23, 2021 at 08:44:29AM -0700, Dave Jiang wrote:

> 1. Introduce UACCE framework support for idxd and have a wq driver resides
> under drivers/misc/uacce/idxd to support the char device operations and
> deprecate the current custom char dev in idxd. This should remove the burden
> on you to deal with the char device.

Gah, I feel I already complained at Intel for cramming their own
private char devices into subsystems! *subsystems* define the user
API, not random drivers in them.

uacce is a reasonable place to put something like this if there isn't
a multi-driver standard

If this is the plan we should block of the char dev under
CONFIG_EXPERIMENTAL or something to discourage people using the uAPI
we are planning to delete

Jason
